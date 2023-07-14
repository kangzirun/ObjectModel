<?php

namespace app\api\controller;


use app\admin\model\Device;
use app\admin\model\Eventlog;
use app\admin\model\Productmodel;
use app\common\controller\Api;
use think\Log;
use Simps\MQTT\Client;
use Simps\MQTT\Config\ClientConfig;

class Clientbuilder extends Api{

    public function connect($clientId){

        
    }
    
    public function send($clientId,$message){
        $config=[
            'userName' => 'user',
            'password' => '123456',
            'clientId' => 'mqttx_1830a10a',
            'keepAlive' => 10,
            'protocolName' => 'MQTT', // or MQIsdp
            'protocolLevel' => 4, // or 3, 5
            'properties' => [], // optional in MQTT5
            'delay' => 3000, // 3s
            'maxAttempts' => 5,
            'swooleConfig' => []
        ];
        $will = [
            'topic' => '', // 主题
            'qos' => 1, // QoS等级
            'retain' => 0, // retain标记
            'message' => '', // 遗嘱消息内容
            'properties' => [], // MQTT5 中需要，可选
        ];
        $configObj =new ClientConfig($config);
        $client= new Client('127.0.0.1',1883,$configObj);
        $client->connect(true,$will);

        $topic='/2/mqttx_1830a10a/info/get';
        
        $result=json_encode($message);
        $client->publish($topic,$result);
        echo '成功';
        
    }
    
}