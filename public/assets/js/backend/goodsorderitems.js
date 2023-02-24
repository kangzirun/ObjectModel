define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'goodsorderitems/index' + location.search,
                    add_url: 'goodsorderitems/add',
                    edit_url: 'goodsorderitems/edit',
                    del_url: 'goodsorderitems/del',
                    multi_url: 'goodsorderitems/multi',
                    import_url: 'goodsorderitems/import',
                    table: 'goodsorderitems',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'itemsid',
                sortName: 'itemsid',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'itemsid', title: __('Itemsid')},
                        {field: 'itemsname', title: __('Itemsname'), operate: 'LIKE'},
                        {field: 'itemsimage', title: __('Itemsimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'itemsunit', title: __('Itemsunit')},
                        {field: 'itemsprice', title: __('Itemsprice'), operate:'BETWEEN'},
                        {field: 'itemsquantity', title: __('Itemsquantity')},
                        {field: 'items_idss', title: __('Items_idss'), operate: 'LIKE'},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        list: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'goodsorderitems/list' + location.search,
                    table: 'goodsorderitems',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'itemsid',
                sortName: 'itemsid',
                columns: [
                    [
                        // {checkbox: true},
                        {field: 'itemsid', title: __('订单货品ID')},
                        {field: 'itemsname', title: __('Itemsname'), operate: 'LIKE'},
                        {field: 'itemsimage', title: __('Itemsimage'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image},
                        {field: 'itemsunit', title: __('Itemsunit')},
                        {field: 'itemsprice', title: __('Itemsprice'), operate:'BETWEEN'},
                        {field: 'itemsquantity', title: __('Itemsquantity')},
                        // {field: 'items_idss', title: __('Items_idss'), operate: 'LIKE'},
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
