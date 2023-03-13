<?php

//安装依赖
//composer require alibabacloud/imageenhan-20190930


namespace app\admin\controller;

use AlibabaCloud\SDK\Imageenhan\V20190930\Imageenhan;
use AlibabaCloud\SDK\Imageenhan\V20190930\Models\GenerateImageWithTextAndImageRequest;
use AlibabaCloud\SDK\Imageenhan\V20190930\Models\GenerateImageWithTextRequest;
use AlibabaCloud\SDK\Imageenhan\V20190930\Models\GetAsyncJobResultRequest;
use AlibabaCloud\Tea\Utils\Utils\RuntimeOptions;
use Darabonba\OpenApi\Models\Config;
use Exception;
use think\addons\Controller;
// require '../vendor/autoload.php';

class GenerateImageWithText extends Controller
{

  // 图+文==》图
  public function index($args)
  {
    $resp = self::image2image($args);
    // 查询任务
    return json($resp);
  }

  // 文生图
  public function text2image($text,$resolution,$number)
  {
    // $text = $this->request->get("text", "一只戴着太阳镜的小松鼠在演奏吉他");
    // $number = $this->request->get("number", "1");
    $client = self::createClient();
    $generateImageWithTextRequest = new GenerateImageWithTextRequest([
      "text" => $text,
      "resolution" => $resolution,
      "number" => (int)$number
    ]);
    $runtime = new RuntimeOptions([]);
    try {
      $resp = $client->generateImageWithTextWithOptions($generateImageWithTextRequest, $runtime);
      // return json($resp->body->requestId);
      return $resp->body->requestId;
    } catch (Exception $exception) {
      throw $exception;
    }
  }


  // 上面的任务提交后，就跳转到结果页(将任务结果带到结果页)，结果页通过定时器不断请求
  // 由于任务很长 所以阿里是异步任务，需要再前端通过定时器定时查询任务结果  setInterval(query , 1000)
  public function query($jobId)
  {
    // $jobId = $this->request->get("job");
    $client = self::createClient();
    $resp  =  $client->getAsyncJobResult(new GetAsyncJobResultRequest(["jobId" => $jobId]));
    
    return $resp->body->data;
  }
  /**
   * 使用AK&SK初始化账号Client
   * @param string $accessKeyId
   * @param string $accessKeySecret
   * @return Imageenhan Client
   */
  public static function createClient()
  {

    // 最好重插件获得以下配置参数
    $config = Config::fromMap([
      // 必填，您的 AccessKey ID
      "accessKeyId" => "LTAI5tEyxhtYW8byUrgGRWyv",
      // 必填，您的 AccessKey Secret
      "accessKeySecret" => "t64MeuPlc61oCVMjRSa79cwZbqBknA"
    ]);
    // 访问的域名
    $config->endpoint = "imageenhan.cn-shanghai.aliyuncs.com";
    return new Imageenhan($config);
  }
  /**
   * @param string  $text
   * @return GenerateImageWithTextAndImageResponseBody
   */
  public static function image2image($args)
  {
    $client = self::createClient();
    $generateImageWithTextAndImageRequest = new GenerateImageWithTextAndImageRequest([
      "text" =>$args['text'],
      "resolution" => $args['resolution'],
      "number" => $args['number'],
      "similarity" => $args['similarity'],
      "refImageUrl" => $args['refImageUrl'],
      "aspectRatioMode" => $args['aspectRatioMode']
    ]);
    $runtime = new RuntimeOptions([]);
    try {
      $resp = $client->generateImageWithTextAndImageWithOptions($generateImageWithTextAndImageRequest, $runtime);
      # 获取整体结果
      return $resp->body->requestId;
    } catch (Exception $exception) {
      # 获取整体报错信息
      // echo Utils::toJSONString($exception);
      # 获取单个字段
      //echo $exception->getCode();
      throw $exception;
    }
  }
}