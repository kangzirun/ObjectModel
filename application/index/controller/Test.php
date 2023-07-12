<?php

namespace app\index\controller;

use app\common\controller\Frontend;

class Test extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    protected $layout = '';

    public function hello()
    {
        echo 'name';
    }

}
