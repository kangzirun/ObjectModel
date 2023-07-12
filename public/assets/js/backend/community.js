define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'community/index' + location.search,
                    add_url: 'community/add',
                    edit_url: 'community/edit',
                    del_url: 'community/del',
                    multi_url: 'community/multi',
                    import_url: 'community/import',
                    table: 'community',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'name', title: __('Name'), operate: 'LIKE'},
                        {field: 'price', title: __('Price'), operate:'BETWEEN'},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate},
                        {field: 'buttons', title: __('是否发货'), table: table, events: Table.api.events.operate,formatter: Table.api.formatter.buttons,buttons:[
                            {
                                name: 'ajax',
                                text: __('是'),
                                title: __('订单货品详情'),
                                classname: 'btn btn-primary btn-xs btn-dialog',
                                icon: 'fa fa-list',
                                url: './ceshi2/search',
                                callback:function(data){

                                },
                                visible:function(row){
                                    return true;
                                }
                            },
                            {
                                name: 'ajax',
                                text: __('获取'),
                                title: __('订单货品详情'),
                                classname: 'btn btn-primary btn-xs btn-dialog',
                                icon: 'fa fa-list',
                                url: './ceshi2/getAll',
                                callback:function(data){

                                },
                                visible:function(row){
                                    return true;
                                }
                            },
                        ]
                    },
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
