define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'eventlog/index' + location.search,
                    add_url: 'eventlog/add',
                    edit_url: 'eventlog/edit',
                    del_url: 'eventlog/del',
                    multi_url: 'eventlog/multi',
                    import_url: 'eventlog/import',
                    table: 'eventlog',
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
                        {field: 'type', title: __('日志类型'), operate: 'LIKE',searchList: 
                        {"property": '属性上报',"function": '功能上报',"event": '事件上报',"online": '设备上线',"offline": '设备离线'},formatter:Table.api.formatter.flag},
                        {field: 'mode', title: __('Mode'), operate: 'LIKE'},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'identifier', title: __('Identifier'), operate: 'LIKE'},
                        {field: 'action', title: __('Action'), operate: 'LIKE'},
                        {field: 'remark', title: __('Remark'), operate: 'LIKE'},
                        // {field: 'data', title: __('Data')},
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
