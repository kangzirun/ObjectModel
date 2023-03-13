<?php

namespace app\admin\controller;

// use AlibabaCloud\SDK\Imageenhan\V20190930\Models\GenerateImageWithTextRequest;
use app\common\controller\Backend;

use app\admin\library\Auth;
use Exception;
use app\admin\controller\GenerateImageWithText;

use think\App;
use think\Http;


/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Ceshi1 extends Backend
{

    /**
     * Ceshi1模型对象
     * @var \app\admin\model\Ceshi1
     */
    protected $model = null;
    
    // public $args=[];

    public function _initialize()
    {
        
        parent::_initialize();
        $this->model = new \app\admin\model\Ceshi1;
        $this->view->assign("statusList", $this->model->getStatusList());
        $this->view->assign("aspectRatioMode",'{"name":["center_crop"]}');
        //$this->view->assign("text","123");
    }
    //文生图
    public function create(){
        if (false === $this->request->isPost()) {
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);

        if ($this->dataLimit && $this->dataLimitFieldAutoFill) {
            $params[$this->dataLimitField] = $this->auth->id;
        }
        $result = false;
        $text=$params['imagetext'];
        $resolution=$params['size1'].'*'.$params['size2'];
        $number=$params['number'];
        $generateImageWithText=new GenerateImageWithText;
        $data=$generateImageWithText->text2image($text,$resolution,$number);
        $args=[
            "jobId" => $data,
            "number" => $params['number']
        ];
        $this->success("文生图成功",'',$args);



    }

    //生成结果
    public function imageResult(){
        // echo "123";
        // $data=session('args');
        // $this->view->assign("args",$this->args);
        $id=input("id");
        $number=input("number");
        $generateImageWithText=new GenerateImageWithText;
        $data=$generateImageWithText->query($id);
        $status=$data->status;
        $this->assignconfig('status',$status);
        $this->assignconfig('jobId',$id);
        $json_data=json_decode($data->result,true);
        if($status==='PROCESS_SUCCESS'){
            $imageUrls=$json_data['imageUrls'][0];       
            // print_r($imageUrls);
            $this->view->assign("imageUrls",$imageUrls);    
        }else{
            $this->view->assign("imageUrls",'null');
        }   
        $this->view->assign("status",$status);
        $this->view->assign("number",$number);
        return $this->view->fetch(); 
        // return $data;
        

    }

    //图文生图
    public function createimagetext(){
        if (false === $this->request->isPost()) {
            
            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);

        if ($this->dataLimit && $this->dataLimitFieldAutoFill) {
            $params[$this->dataLimitField] = $this->auth->id;
        }
        $result = false;
        $args=[
            "text" => $params['imagetext'],
            "resolution" => $params['size1'].'*'.$params['size2'],
            "number" => $params['number'],
            "similarity"=>$params['similarity'],
            "refImageUrl"=>$params['refImageUrl'],
            "aspectRatioMode"=>$params['aspectRatioMode']
        ];
        $generateImageWithText=new GenerateImageWithText;
        $data=$generateImageWithText->image2image($args);
        $result=[
            "jobId" => $data,
            "number" => $params['number']
        ];
        $this->success("图文生图成功",'',$result);


    }
    // public function createimagetextresult(){
    //     $id=input("id");
    //     $number=input("number");
    //     $generateImageWithText=new GenerateImageWithText;
    //     $data=$generateImageWithText->query($id);

    //     print_r($data);
    // }
    
    



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}


