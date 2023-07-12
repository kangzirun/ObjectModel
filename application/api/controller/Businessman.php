<?php

namespace app\api\controller;


use app\common\controller\Api;
use think\Db;

class Businessman extends Api{

      /**
   * 无需登录的方法,同时也就不需要鉴权了
   * @var array
   */
  protected $noNeedLogin = ['*'];

  /**
   * 无需鉴权的方法,但需要登录
   * @var array
   */
  protected $noNeedRight = ['*'];

    public function search($id){
        
        // $id=input('value');
        $name=Db::name('newscategroy')->where('categroy_id',$id)->value('name');
        $this->success('',$name);

    }

    public function hello($id){
        // $name=input('name');
        echo $id;
    }


}