<?php

namespace app\api\controller;

use app\admin\model\Device;
use app\admin\model\Eventlog;
use app\admin\model\Productmodel;
use app\common\controller\Api;
use think\Log;

/**
 * 首页接口
 */
class Mqtt extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];


    function extractParameters($string)
    {
        $parts = explode('/', $string);
        $result = array_filter($parts); // 去除空元素
        return $result;
    }

    public function topic()
    {
        $data = $this->request->post();
        Log::write($data);
        //设备id
        $clientid = $data['clientid'];
        //设备主题
        $topic = $data['topic'];
        //数据
        $payload = $data['payload'];
        $parameters = $this->extractParameters($topic);
        Log::write($parameters);

        $productId = $parameters[1];
        $deviceNum = $parameters[2];

        $productModel = new Productmodel();
        $eventlogModel = new Eventlog();

        //发布设备信息
        if (strpos($topic, '/info/post')) {
            $deviceModel = new Device();
            $status = $payload['status'] == 3 ? 1 : 0;
            $firmwareVersion = $payload['firmwareVersion'];
            $longitude = $payload['longitude'];
            $latitude = $payload['latitude'];
            //对设备信号进行判定
            if ($payload['rssi'] >= -55 && $payload['rssi'] <= 0) {
                //信号极好
                $rssi = 1;
            } elseif ($payload['rssi'] >= -70 && $payload['rssi'] < -55) {
                //信号好
                $rssi = 0;
            } elseif ($payload['rssi'] >= -85 && $payload['rssi'] < -70) {
                //信号一般
                $rssi = 3;
            } elseif ($payload['rssi'] >= -100 && $payload['rssi'] < -85) {
                //信号差
                $rssi = 2;
            }
            $infoResult = [
                'rssi' => $rssi,
                'status' => $status,
                'version' => $firmwareVersion,
                'longitude' => $longitude,
                'latitude' => $latitude
            ];
            //同步更新设备信息
            $deviceModel->update($infoResult, ['id' => $deviceNum]);

            //同步上传日志
            if ($payload['status'] == 3) {
                $items = [
                    'type' => 'online',
                    'mode' => '其他信息',
                    'identifier' => 'online',
                    'action' => '设备上线',
                    'remark' => '设备上线',
                    'data' => json_encode($payload),
                    'device_id' => $deviceNum
                ];
                $eventlogModel->create($items);
            }
        }

        //发布实时监测
        if (strpos($topic, '/monitor/post')) {
        }

        //发布时钟同步
        if (strpos($topic, '/ntp/post')) {
        }

        /**
         * 发布属性/功能/事件
         */

        //设备发布属性

        if (strpos($topic, '/property/post')) {
            // 1. 找到N个物模型
            // 2. 写日志
            foreach ($payload as $result) {
                Log::write('消息' . json_encode($result));
                $identifier = $result['id'];
                $name = $productModel->getNameByIdentifier($productId, $identifier);
                $items = [
                    'type' => 'property',
                    'mode' => '其他信息',
                    'identifier' => $identifier,
                    'action' => $name . ' : ' . $result['value'],
                    'remark' => $result['remark'],
                    'data' => json_encode($result),
                    'device_id' => $deviceNum
                ];

                $eventlogModel->create($items);
            }
        }
        //设备发布功能
        if (strpos($topic, '/function/post')) {

            foreach ($payload as $result) {
                Log::write('消息' . json_encode($result));
                $identifier = $result['id'];
                $name = $productModel->getNameByIdentifier($productId, $identifier);
                $items = [
                    'type' => 'function',
                    'mode' => '其他信息',
                    'identifier' => $identifier,
                    'action' => $name . ' : ' . $result['value'],
                    'remark' => $result['remark'],
                    'data' => json_encode($result),
                    'device_id' => $deviceNum
                ];

                $eventlogModel->create($items);
            }
        }

        //设备发布事件
        if (strpos($topic, '/event/post')) {

            foreach ($payload as $result) {
                Log::write('消息' . json_encode($result));
                $identifier = $result['id'];
                $name = $productModel->getNameByIdentifier($productId, $identifier);
                $items = [
                    'type' => 'event',
                    'mode' => '其他信息',
                    'identifier' => $identifier,
                    'action' => $name . ' : ' . $result['value'],
                    'remark' => $result['remark'],
                    'data' => json_encode($result),
                    'device_id' => $deviceNum
                ];

                $eventlogModel->create($items);
            }
        }

        Log::write($payload);
    }
}
