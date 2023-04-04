<?php

namespace app\admin\controller;

use app\admin\model\Objectmodel;
use app\admin\model\Productmodel as ModelProductmodel;
use app\common\controller\Backend;
use think\Db;
use Exception;
use think\console\output\descriptor\Console;
use think\exception\PDOException;
use think\exception\ValidateException;
use think\Log;

/**
 * 
 *
 * @icon fa fa-circle-o
 */
class Productmodel extends Backend
{
   


    private $productid;
    /**
     * Productmodel模型对象
     * @var \app\admin\model\Productmodel
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Productmodel;
        $this->view->assign("modelNameList", Db::name('objectmodel')->field('id,name')->select());

    }

            /**
     * 查看
     *
     * @return string|Json
     * @throws \think\Exception
     * @throws DbException
     */
    
     public function index()
     {     
         $productid=input('productid');
         $this->assign('productid',$productid);
         //设置过滤方法
         $this->request->filter(['strip_tags', 'trim']);
         if (false === $this->request->isAjax()) {
             return $this->view->fetch();
         }
         //如果发送的来源是 Selectpage，则转发到 Selectpage
         if ($this->request->request('keyField')) {
             return $this->selectpage();
         }
         [$where, $sort, $order, $offset, $limit] = $this->buildparams();
         $list = $this->model
             ->where('productid',$productid)
             ->where($where)
             ->order($sort, $order)
             ->paginate($limit);
         $result = ['total' => $list->total(), 'rows' => $list->items()];
         return json($result);
     }

         /**
     * 添加
     *
     * @return string
     * @throws \think\Exception
     */
    public function add()
    {
        $addid=input('id');
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
        Log::write($addid);
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : $name) : $this->modelValidate;
                $this->model->validateFailException()->validate($validate);
            }  
            $addtype=$params['addtype'];
            if($addtype=='manual'){                
                $tool=new Tool;  
                $params=[                                              
                    'name'=>$params['name'],
                    'identifier'=>$params['identifier'],
                    'weigh'=>$params['weigh'],
                    'tag'=>$params['tag'],
                    'readswitch'=>$params['readswitch'],
                    'chartswitch'=>$params['chartswitch'],
                    'datatype'=>$params['datatype'],               
                    'definition'=>$tool->dataJoint($params), 
                    'productid'=>$addid      
                ];
                $result = $this->model->allowField(true)->save($params);  
            }   
            if($addtype=='convenience'){
                $tool=new Tool;
                $mdoelInfos=json_decode($params['convenienceName'],true);
                Log::write($params['convenienceName']);
                foreach($mdoelInfos as $infos){
                    $productModel=Objectmodel::get($infos['id']);                  
                    $productInfo=[
                        'name'=>$productModel->name,
                        'identifier'=>$productModel->identifier,
                        'weigh'=>$productModel->weigh,
                        'tag'=>$tool->transformTag($productModel->tag),
                        'readswitch'=>$productModel->readswitch,
                        'chartswitch'=>$productModel->chartswitch,
                        'datatype'=>$tool->transformDatatype($productModel->datatype),               
                        'definition'=>$productModel->definition,  
                        'productid'=>$addid   
                    ];                    
                    $result = $this->model->allowField(true)->save($productInfo);                          
                }
               
            }   
                       
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
     * 编辑
     *
     * @param $ids
     * @return string
     * @throws DbException
     * @throws \think\Exception
     */
    public function edit($ids = null)
    {
        $row = $this->model->get($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds) && !in_array($row[$this->dataLimitField], $adminIds)) {
            $this->error(__('You have no permission'));
        }
        if (false === $this->request->isPost()) {
            $this->view->assign('row', $row);
            //tag回显
            $tag=$this->model::where('id',$ids)->value('tag');
            if($tag=='events'){
                $this->view->assign("tag",'events');
            }
            if($tag=='properties'){
                $this->view->assign("tag",'properties');
            }
            if($tag=='functions'){
                $this->view->assign("tag",'functions');
            }
            //datatype回显
            $datatype=$this->model::where('id',$ids)->value('definition');
            $definition=json_decode($datatype,true);
            if($definition['type']=='integer'){
                $this->view->assign("datatype",'integer');
                $this->view->assign("min",$definition['min']);
                $this->view->assign("max",$definition['max']);
                $this->view->assign("step",$definition['step']);
                $this->view->assign("unit",$definition['unit']);
            }
            if($definition['type']=='decimal'){
                $this->view->assign("datatype",'decimal');
                $this->view->assign("min",$definition['min']);
                $this->view->assign("max",$definition['max']);
                $this->view->assign("step",$definition['step']);
                $this->view->assign("unit",$definition['unit']);
            }
            if($definition['type']=='string'){
                $this->view->assign("datatype",'string');
                $this->view->assign("maxLength",$definition['maxLength']);
            }
            if($definition['type']=='enum'){
                $this->view->assign("datatype",'enum');
            }
            if($definition['type']=='array'){
                $this->view->assign("datatype",'array');
                $this->view->assign("arrayCount",$definition['arrayCount']);
                $this->view->assign("arrayType",$definition['arrayType']);
                
            }
            if($definition['type']=='bool'){
                $this->view->assign("datatype",'bool');
                $this->view->assign("trueText",$definition['trueText']);
                $this->view->assign("falseText",$definition['falseText']);
            }
            if($definition['type']=='object'){
                $this->view->assign("datatype",'object');
            }

            return $this->view->fetch();
        }
        $params = $this->request->post('row/a');
        if (empty($params)) {
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $params = $this->preExcludeFields($params);
        $result = false;
        Db::startTrans();
        try {
            //是否采用模型验证
            if ($this->modelValidate) {
                $name = str_replace("\\model\\", "\\validate\\", get_class($this->model));
                $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : $name) : $this->modelValidate;
                $row->validateFailException()->validate($validate);
            }
            $tool=new Tool;
            $params=[                                              
                'name'=>$params['name'],
                'identifier'=>$params['identifier'],
                'weigh'=>$params['weigh'],
                'tag'=>$params['tag'],
                'readswitch'=>$params['readswitch'],
                'chartswitch'=>$params['chartswitch'],
                'datatype'=>$params['datatype'],               
                'definition'=>$tool->dataJoint($params)              
            ];
            $result = $row->allowField(true)->save($params);
            Db::commit();
        } catch (ValidateException|PDOException|Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if (false === $result) {
            $this->error(__('No rows were updated'));
        }
        $this->success();
    }

    //查看你物模型
    public function check(){
        $productid=input('productid');

        $definition=$this->model::where('productid',$productid)->column('definition');
        $tag=$this->model::where('productid',$productid)->column('tag');
        $identifier=$this->model::where('productid',$productid)->column('identifier');
        $name=$this->model::where('productid',$productid)->column('name');

        $properties=array();
        $functions=array();
        $events=array();
        for($i=0;$i<count($definition);$i++){
            if($tag[$i]=='properties'){
                array_push($properties,['id'=>$identifier[$i],'name'=>$name[$i],'datatype'=>$definition[$i]]);                 
            }
            if($tag[$i]=='functions'){
                array_push($functions,['id'=>$identifier[$i],'name'=>$name[$i],'datatype'=>$definition[$i]]);                             
            }
            if($tag[$i]=='events'){
                array_push($events,['id'=>$identifier[$i],'name'=>$name[$i],'datatype'=>$definition[$i]]);                              
            }
        }
        $jsondata=array(
            'properties'=>$properties,
            'functions'=>$functions,
            'events'=>$events
        );
        Log::write($jsondata);        
        $arraydata=json_decode(json_encode($jsondata),true);
        print_r($arraydata);
        // print_r(json_decode($arraydata['functions'][0][0],true)['name']);
        // print_r($arraydata['functions'][1]['name']);✔
        
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */


}
