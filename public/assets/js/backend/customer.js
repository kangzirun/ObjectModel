define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'customer/index' + location.search,
                    add_url: 'customer/add',
                    edit_url: 'customer/edit',
                    del_url: 'customer/del',
                    multi_url: 'customer/multi',
                    import_url: 'customer/import',
                    table: 'customer',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'customerid',
                sortName: 'customerid',
                columns: [
                    [
                        {checkbox: true},
                        
                        {field: 'customername', title: __('Customername'), operate: 'LIKE'},
                        {field: 'customermemo', title: __('Customermemo'), operate: 'LIKE'},
                        {field: 'customeraddress_id', title: __('Customeraddress_id'), operate: 'LIKE'},
                        {field: 'customeravatar', title: __('Customeravatar'), operate: 'LIKE', events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'customerphone', title: __('客户电话'), operate: 'LIKE'},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate,buttons:[
                            {
                                name: 'detail',
                                text: __('查看订单'),
                                title: __('订单详情'),
                                classname: 'btn btn-primary btn-xs btn-dialog',
                                icon: 'fa fa-list',
                                url: './goodsorder/list?customer_id={customerid}',
                                callback:function(data){

                                },
                                visible:function(row){
                                    return true;
                                }
                            }
                        ]
                    
                        }
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
