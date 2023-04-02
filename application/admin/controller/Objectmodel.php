<?php

namespace app\admin\controller;

use app\admin\model\Objectmodel as ModelObjectmodel;
use app\common\controller\Backend;

use think\Log;
use think\Db;
use Exception;
use think\console\output\descriptor\Console;
use think\exception\PDOException;
use think\exception\ValidateException;
/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Objectmodel extends Backend
{

    /**
     * Objectmodel模型对象
     * @var \app\admin\model\Objectmodel
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Objectmodel;
        $this->view->assign("modelNameList", Db::name('objectmodel')->field('id,name')->select());
    }

        /**
     * 添加
     *
     * @return string
     * @throws \think\Exception
     */
    public function add()
    {
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
        Db::startTrans();
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : $name) : $this->modelValidate;
                $this->model->validateFailException()->validate($validate);
            }
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
                    $datatype=ModelObjectmodel::where('id',$infos['id'])->value('definition');
                    $objectname=ModelObjectmodel::where('id',$infos['id'])->value('name');
                    array_push($enumList,['objectname'=>$objectname,'datatype'=>$datatype]);
                }
                $jsondata=array(
                    'type'=>$params['datatype'],
                    'objecttype'=>$enumList
                );
                $definition=json_encode($jsondata); 
            }

            $params=[                                              
                'name'=>$params['name'],
                'identifier'=>$params['identifier'],
                'weigh'=>$params['weigh'],
                'tag'=>$params['tag'],
                'readswitch'=>$params['readswitch'],
                'chartswitch'=>$params['chartswitch'],
                'datatype'=>$params['datatype'],               
                'definition'=>$definition              
            ];
            $result = $this->model->allowField(true)->save($params);
            Db::commit();
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result === false) {
            $this->error(__('No rows were inserted'));
        }
        $this->success();
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
