define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'goodsorder/index' + location.search,
                    add_url: 'goodsorder/add',
                    edit_url: 'goodsorder/edit',
                    del_url: 'goodsorder/del',
                    multi_url: 'goodsorder/multi',
                    import_url: 'goodsorder/import',
                    table: 'goodsorder',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'orderid',
                sortName: 'orderid',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'orderid', title: __('Orderid')},
                        {field: 'buttons', title: __('查看订单'), table: table, events: Table.api.events.operate,formatter: Table.api.formatter.buttons,buttons:[
                                {
                                    name: 'detail',
                                    text: __('点击查看'),
                                    title: __('订单货品详情'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa fa-list',
                                    url: './goodsorderitems/list?id={orderid}',
                                    callback:function(data){

                                    },
                                    visible:function(row){
                                        return true;
                                    }
                                }
                            ]
                        },
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'customer_id', title: __('Customer_id')},
                        {field: 'address_id', title: __('Address_id'), operate: 'LIKE'},
                        {field: 'name_id', title: __('Name_id'), operate: 'LIKE'},
                        {field: 'phone_id', title: __('Phone_id'), operate: 'LIKE'},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},
                        {field: 'totalprice', title: __('订单总价(元)')},
                        {field: 'buttons', title: __('是否发货'), table: table, events: Table.api.events.operate,formatter: Table.api.formatter.buttons,buttons:[
                                {
                                    name: 'ajax',
                                    text: __('是'),
                                    title: __('订单货品详情'),
                                    classname: 'btn btn-info btn-xs btn-ajax',
                                    icon: 'fa fa-list',
                                    url: './goodsorder/updateStatus1?id={orderid}',
                                    callback:function(data){

                                    },
                                    visible:function(row){
                                        return true;
                                    }
                                },
                                {
                                    name: 'ajax1',
                                    text: __('否'),
                                    title: __('订单货品详情'),
                                    classname: 'btn btn-info btn-xs btn-ajax',
                                    icon: 'fa fa-list',
                                    url: './goodsorder/updateStatus2?id={orderid}',
                                    callback:function(data){

                                    },
                                    visible:function(row){
                                        return true;
                                    }
                                }
                            ]
                        },
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate,buttons:[
                                {
                                    name: 'ajax',
                                    text: __('取消订单'),
                                    title: __('订单货品详情'),
                                    classname: 'btn btn-info btn-xs btn-ajax',
                                    icon: 'fa fa-list',
                                    url: './goodsorder/updateStatus3?id={orderid}',
                                    callback:function(data){

                                    },
                                    visible:function(row){
                                        return true;
                                    }
                                },
                            ]

                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        list: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'goodsorder/index' + location.search,
                    add_url: 'goodsorder/add',
                    edit_url: 'goodsorder/edit',
                    del_url: 'goodsorder/del',
                    multi_url: 'goodsorder/multi',
                    import_url: 'goodsorder/import',
                    table: 'goodsorder',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'orderid',
                sortName: 'orderid',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'orderid', title: __('Orderid')},
                        {field: 'buttons', title: __('查看订单'), table: table, events: Table.api.events.operate,formatter: Table.api.formatter.buttons,buttons:[
                                {
                                    name: 'detail',
                                    text: __('点击查看'),
                                    title: __('订单货品详情'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa fa-list',
                                    url: './goodsorderitems/list?id={orderid}',
                                    callback:function(data){

                                    },
                                    visible:function(row){
                                        return true;
                                    }
                                }
                            ]
                        },
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'customer_id', title: __('Customer_id')},
                        {field: 'address_id', title: __('Address_id'), operate: 'LIKE'},
                        {field: 'name_id', title: __('Name_id'), operate: 'LIKE'},
                        {field: 'phone_id', title: __('Phone_id'), operate: 'LIKE'},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"1":__('Status 1'),"2":__('Status 2')}, formatter: Table.api.formatter.status},
                        {field: 'totalprice', title: __('订单总价(元)')},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});
