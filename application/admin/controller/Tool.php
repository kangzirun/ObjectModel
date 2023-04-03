<?php

namespace app\admin\controller;
use app\admin\model\Objectmodel;

class Tool{

    public function dataJoint($params){
        if($params['datatype']=='integer'){
            $jsondata=array(
                'min'=>$params['integermin'],
                'max'=>$params['integermax'],
                'unit'=>$params['integerunit'],
                'step'=>$params['integerstep'],
                'type'=>$params['datatype']
            );
            $definition=json_encode($jsondata);                
        }
        if($params['datatype']=='decimal'){
            $jsondata=array(
                'min'=>$params['min'],
                'max'=>$params['max'],
                'unit'=>$params['unit'],
                'step'=>$params['step'],
                'type'=>$params['datatype']
                
            );
            $definition=json_encode($jsondata);                
        }
        if($params['datatype']=='bool'){
            $jsondata=array(
                'trueText'=>$params['trueText'],
                'falseText'=>$params['falseText'],
                'type'=>$params['datatype']
            );
            $definition=json_encode($jsondata); 
        }
        if($params['datatype']=='enum'){
            $enumList=array();
            $enumInfos=json_decode($params['multiplejson'],true);
            foreach($enumInfos as $items){
                $text=$items['text'];
                $value=$items['value'];
                array_push($enumList,['text'=>$text,'value'=>$value]);
            }
            $jsondata=array(
                'type'=>$params['datatype'],
                'enumList'=>$enumList
            );
            $definition=json_encode($jsondata); 
        }
        if($params['datatype']=='string'){
            $jsondata=array(
                'maxLength'=>$params['maxLength'],
                'type'=>$params['datatype']
            );
            $definition=json_encode($jsondata); 
        }
        if($params['datatype']=='array'){
            $jsondata=array(
                'arrayCount'=>$params['arrayCount'],
                'arrayType'=>$params['arrayType'],
                'type'=>$params['datatype']
            );
            $definition=json_encode($jsondata); 
        }
        if($params['datatype']=='object'){
            $enumList=array();
            $objectInfos=json_decode($params['modelName'],true);
            foreach($objectInfos as $infos){
                $datatype=Objectmodel::where('id',$infos['id'])->value('definition');
                $objectname=Objectmodel::where('id',$infos['id'])->value('name');
                array_push($enumList,['objectname'=>$objectname,'datatype'=>$datatype]);
            }
            $jsondata=array(
                'type'=>$params['datatype'],
                'objecttype'=>$enumList
            );
            $definition=json_encode($jsondata); 
        }
        return $definition;
    }
    public function transformTag($value){
        if($value=='属性'){$tag='properties';}
        if($value=='事件'){$tag='events';}
        if($value=='功能'){$tag='functions';}
        return $tag;
    }
    public function transformDatatype($value){
        if($value=='布尔'){$datatype='bool';}
        if($value=='整数'){$datatype='integer';}
        if($value=='小数'){$datatype='decimal';}
        if($value=='枚举'){$datatype='enum';}
        if($value=='数组'){$datatype='array';}
        if($value=='字符串'){$datatype='string';}
        if($value=='对象'){$datatype='object';}  
        return $datatype;
    }

}