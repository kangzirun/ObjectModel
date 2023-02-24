define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'customeraddress/index' + location.search,
                    add_url: 'customeraddress/add',
                    edit_url: 'customeraddress/edit',
                    del_url: 'customeraddress/del',
                    multi_url: 'customeraddress/multi',
                    import_url: 'customeraddress/import',
                    table: 'customeraddress',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'addressid',
                sortName: 'addressid',
                columns: [
                    [
                        {checkbox: true},
                        
                        {field: 'addressname', title: __('Addressname'), operate: 'LIKE'},
                        {field: 'addressmobile', title: __('Addressmobile'), operate: 'LIKE'},
                        
                        {field: 'addressphone', title: __('Addressphone'), operate: 'LIKE'},
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
