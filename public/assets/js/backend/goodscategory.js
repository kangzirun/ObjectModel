define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'goodscategory/index' + location.search,
                    add_url: 'goodscategory/add',
                    edit_url: 'goodscategory/edit',
                    del_url: 'goodscategory/del',
                    multi_url: 'goodscategory/multi',
                    import_url: 'goodscategory/import',
                    table: 'goodscategory',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'categoryid',
                sortName: 'categoryid',
                columns: [
                    [
                        {checkbox: true},
                        
                        {field: 'categoryname', title: __('Categoryname'), operate: 'LIKE'},
                        {field: 'categoryimage', title: __('Categoryimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
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
