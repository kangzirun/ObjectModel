define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'newscategroy/index' + location.search,
                    add_url: 'newscategroy/add',
                    edit_url: 'newscategroy/edit',
                    del_url: 'newscategroy/del',
                    multi_url: 'newscategroy/multi',
                    import_url: 'newscategroy/import',
                    table: 'newscategroy',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'categroy_id',
                sortName: 'categroy_id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'categroy_id', title: __('Categroy_id')},
                        {field: 'name', title: __('分类名称'), operate: 'LIKE'},
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
