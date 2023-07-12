define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    function currencyFormatter(value) {
        if (value == 0) {
            return '官方业务员'
        } else {
            fetch(`businessman/${value}`)
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                })
                .catch(error => {
                    // 处理请求错误
                    console.error(error);
                });
        }
    }

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'application/index' + location.search,
                    add_url: 'application/add',
                    edit_url: 'application/edit',
                    del_url: 'application/del',
                    multi_url: 'application/multi',
                    import_url: 'application/import',
                    table: 'application',
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
                        { checkbox: true },
                        { field: 'id', title: __('Id') },
                        { field: 'name', title: __('Name'), operate: 'LIKE' },
                        { field: 'phone', title: __('Phone'), operate: 'LIKE' },
                        { field: 'city', title: __('City'), operate: 'LIKE' },
                        { field: 'county', title: __('County'), operate: 'LIKE' },
                        { field: 'community', title: __('Community'), operate: 'LIKE' },
                        { field: 'status', title: __('Status'), searchList: { "0": __('Status 0'), "1": __('Status 1') }, formatter: Table.api.formatter.status },
                        { field: 'salespersonid', title: __('所属业务员'), formatter: currencyFormatter },
                        { field: 'switch', title: __('Switch'), searchList: { "1": __('Yes'), "0": __('No') }, table: table, formatter: Table.api.formatter.toggle },
                        { field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate }
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
