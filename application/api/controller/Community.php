<?php

namespace app\api\controller;

use app\admin\model\Community as ModelCommunity;
use app\common\controller\Api;


class Community extends Api{

    public function getPrice(){
        echo 'hehe';
        $name=$this->request->post('name');
        $model=new ModelCommunity();
        return $model->search($name);

    }
}