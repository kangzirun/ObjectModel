define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'monitor/index' + location.search,
                    add_url: 'monitor/add',
                    edit_url: 'monitor/edit',
                    del_url: 'monitor/del',
                    multi_url: 'monitor/multi',
                    import_url: 'monitor/import',
                    table: 'monitor',
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
                        
                        {field: 'tag', title: __('类型'), operate: 'LIKE', formatter: Table.api.formatter.flag},
                        {field: 'pattern', title: __('模型'), operate: 'LIKE'},
                        {field: 'createtime', title: __('时间'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'identifier', title: __('标识符'), operate: 'LIKE'},
                        {field: 'action', title: __('动作')},
                        
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
