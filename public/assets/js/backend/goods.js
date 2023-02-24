define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'goods/index' + location.search,
                    add_url: 'goods/add',
                    edit_url: 'goods/edit',
                    del_url: 'goods/del',
                    multi_url: 'goods/multi',
                    import_url: 'goods/import',
                    table: 'goods',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'goodsid',
                sortName: 'goodsid',
                columns: [
                    [
                        {checkbox: true},
            
                        {field: 'goodsname', title: __('Goodsname'), operate: 'LIKE'},
                        {field: 'goodsimage', title: __('Goodsimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'goodsunit', title: __('Goodsunit')},
                        {field: 'goodsprice', title: __('Goodsprice'), operate:'BETWEEN'},
                        {field: 'goodscategory_id', title: __('Goodscategory_id')},
                        
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
