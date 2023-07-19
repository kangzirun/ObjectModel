<?php


namespace app\common\service;


use Simps\MQTT\Client;
use Simps\MQTT\Config\ClientConfig;
use think\Log;

/**
 * 
 */
class MQTTService
{


    public function process($clientId, $topic, $payload)
    {
    }

    /**
     * @param $pid 产品ID
     * @param $clientId 客户端ID
     * @param @message 消息包
     */

    function basicEncode($username, $password)
    {
        $credentials = $username . ':' . $password;
        $encodedCredentials = base64_encode($credentials);
        return 'Basic ' . $encodedCredentials;
    }
    public function send($pid, $clientId, $message, $suffix)
    {


        Log::write('suffix:' . $suffix);
        Log::write('deviceid:' . $clientId);
        Log::write('pid:' . $pid);


        $username = '2af84f674249812e';
        $password = 'LPqW6Vbvhg71gLeS0eACtfO3l69CkNNW4JmfZYrRQ1oE';
        $authorization = $this->basicEncode($username, $password);
        // $topic = '/'+$pid+'/'+$clientId+'/info/get';
        $topic = '/' . $pid . '/' . $clientId . $suffix;
        Log::write('message:' . $message);

        $result = \fast\Http::post(
            "http://localhost:18083/api/v5/publish",
            json_encode(["payload" => $message, "clientid" => $clientId, "topic" => $topic]),
            [CURLOPT_TIMEOUT => 30, CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'Authorization: ' . $authorization]]
        );

        Log::write('result:' . $result);
    }
}
