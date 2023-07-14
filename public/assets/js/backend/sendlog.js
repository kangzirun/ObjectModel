define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'sendlog/index' + location.search,
                    add_url: 'sendlog/add',
                    edit_url: 'sendlog/edit',
                    del_url: 'sendlog/del',
                    multi_url: 'sendlog/multi',
                    import_url: 'sendlog/import',
                    table: 'sendlog',
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
                        // {field: 'id', title: __('Id')},
                        {field: 'identifier', title: __('Identifier'),operate: 'LIKE'},
                        {field: 'type', title: __('Type'), operate: 'LIKE',searchList: 
                        {"property": '属性获取',"function": '服务下发',"ota":"OTA升级"},formatter:Table.api.formatter.flag},
                        {field: 'value', title: __('Value'), operate: 'LIKE'},
                        {field: 'deviceid', title: __('Deviceid'), operate: 'LIKE'},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'detail', title: __('Detail'), operate: 'LIKE'},
                        {field: 'remark', title: __('Remark'), operate: 'LIKE'},
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
