define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'ceshi2/index' + location.search,
                    add_url: 'ceshi2/add',
                    edit_url: 'ceshi2/edit',
                    del_url: 'ceshi2/del',
                    multi_url: 'ceshi2/multi',
                    import_url: 'ceshi2/import',
                    table: 'ceshi2',
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
                        {field: 'smallimage', title: __('Smallimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'smallimages', title: __('Smallimages'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.images},
                        {field: 'attachfile', title: __('Attachfile'), operate: false, formatter: Table.api.formatter.file},
                        {field: 'attachfiles', title: __('Attachfiles'), operate: false, formatter: Table.api.formatter.files},
                        {field: 'status', title: __('Status'), searchList: {"0":__('Status 0'),"1":__('Status 1')}, formatter: Table.api.formatter.status},
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
