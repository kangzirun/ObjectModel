define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'product/index' + location.search,
                    add_url: 'product/add',
                    edit_url: 'product/edit',
                    del_url: 'product/del',
                    multi_url: 'product/multi',
                    import_url: 'product/import',
                    table: 'product',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('产品编号')},
                        {field: 'name', title: __('产品名称'), operate: 'LIKE'},
                        {field: 'category_id', title: __('产品分类'), operate: 'LIKE'},
                        {field: 'devicetype', title: __('设备类型'), operate: 'LIKE'},
                        {field: 'network', title: __('联网方式'), operate: 'LIKE'},
                        {field: 'image', title: __('产品图品'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'switch', title: __('Switch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'authentication', title: __('认证方式'), operate: 'LIKE'},
                        {field: 'mqttaccount', title: __('Mqtt账号'), operate: 'LIKE'},
                        {field: 'mqttpwd', title: __('Mqtt密码'), operate: 'LIKE'},
                        {field: 'buttons', title: __('查看设备'), table: table, events: Table.api.events.operate,formatter: Table.api.formatter.buttons,buttons:[
                            {
                                name: 'detail',
                                text: __('查看设备'),
                                title: __('设备详情'),
                                classname: 'btn btn-primary btn-xs btn-dialog',
                                icon: 'fa fa-list',
                                url: './device/list?productname={name}',
                                callback:function(data){

                                },
                                visible:function(row){
                                    return true;
                                }
                            }
                        ]
                    },
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
