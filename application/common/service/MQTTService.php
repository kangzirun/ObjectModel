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
    public function send($pid, $clientId, $message,$suffix)
    {

        $config = [
            'userName' => 'admin',
            'password' => '123456qq',
            'clientId' => '9d5F1j3W7g0r',
            'keepAlive' => 60,
            'protocolName' => 'MQTT', // or MQIsdp
            'protocolLevel' => 4, // or 3, 5
            'properties' => [], // optional in MQTT5
            'delay' => 3000, // 3s
            'maxAttempts' => 5,
            'swooleConfig' => []
        ];

        Log::write('执行前');

        $configObj = new ClientConfig($config);

        Log::write('执行后');
        $client = new Client('127.0.0.1', 1883, $configObj);
        $client->connect();

        // $topic = '/'+$pid+'/'+$clientId+'/info/get';
        $topic = '/2/9d5F1j3W7g0r/function/get';

        $data = [
            'id'=>'switch',
            'value'=> 1,
            'remark'=>'场景联动'
        ];
        $result = json_encode($data);
        $client->publish($topic, $result);

        // $topics=[
        //     $topic
        // ];

        // return $client->subscribe($topics);

    }
}
