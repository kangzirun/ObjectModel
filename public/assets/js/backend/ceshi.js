define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'ceshi/index' + location.search,
                    add_url: 'ceshi/add',
                    edit_url: 'ceshi/edit',
                    del_url: 'ceshi/del',
                    multi_url: 'ceshi/multi',
                    import_url: 'ceshi/import',
                    table: 'ceshi',
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
                        {field: 'testint', title: __('Testint')},
                        {field: 'testenum', title: __('Testenum'), searchList: {"0":__('Testenum 0'),"1":__('Testenum 1'),"2":__('Testenum 2')}, formatter: Table.api.formatter.normal},
                        {field: 'testset', title: __('Testset'), searchList: {"0":__('Testset 0'),"1":__('Testset 1'),"2":__('Testset 2'),"3":__('Testset 3')}, operate:'FIND_IN_SET', formatter: Table.api.formatter.label},
                        {field: 'testfloat', title: __('Testfloat'), operate:'BETWEEN'},
                        {field: 'admin_id', title: __('Admin_id')},
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
