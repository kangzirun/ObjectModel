define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'device/index' + location.search,
                    add_url: 'device/add',
                    edit_url: 'device/edit',
                    del_url: 'device/del',
                    multi_url: 'device/multi',
                    import_url: 'device/import',
                    table: 'device',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        { checkbox: true },
                        { field: 'id', title: __('设备编号') },
                        { field: 'name', title: __('设备名称'), operate: 'LIKE' },
                        { field: 'product.name', title: __('所属产品'), operate: 'LIKE' },
                        { field: 'version', title: __('固件版本'), operate: 'BETWEEN' },
                        { field: 'image', title: __('设备图片'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image },
                        { field: 'deviceswitch', title: __('Deviceswitch'), searchList: { "1": __('Yes'), "0": __('No') }, table: table, formatter: Table.api.formatter.toggle },
                        { field: 'shadowswitch', title: __('Shadowswitch'), searchList: { "1": __('Yes'), "0": __('No') }, table: table, formatter: Table.api.formatter.toggle },
                        { field: 'createtime', title: __('Createtime'), operate: 'RANGE', addclass: 'datetimerange', autocomplete: false, formatter: Table.api.formatter.datetime },
                        { field: 'longitude', title: __('Longitude'), operate: 'LIKE' },
                        { field: 'latitude', title: __('Latitude'), operate: 'LIKE' },
                        { field: 'status', title: __('Status'), searchList: { "0": __('离线'), "1": __('在线') }, formatter: Table.api.formatter.status },
                        { field: 'rssi', title: __('信号'), searchList: { "0": __('信号好'), "1": __('信号极好'), "2": __('信号差'), "3": __('信号一般') }, formatter: Table.api.formatter.status },
                        // {
                        //     field: 'buttons', title: __('设备日志'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.buttons, buttons: [
                        //         {
                        //             name: 'detail',
                        //             text: __('查看'),
                        //             title: __('日志详情'),
                        //             classname: 'btn btn-primary btn-xs btn-dialog',
                        //             icon: 'fa fa-list',
                        //             url: './devicelog/index',
                        //             callback: function (data) {

                        //             },
                        //             visible: function (row) {
                        //                 return true;
                        //             }
                        //         }
                        //     ]
                        // },
                        {
                            field: 'buttons', title: __('运行状态'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.buttons, buttons: [
                                {
                                    name: 'detail',
                                    text: __('设置'),
                                    title: __('设备详情'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa',
                                    url: './productmodel/set?id={id}',
                                    callback: function (data) {

                                    },
                                    visible: function (row) {
                                        return true;
                                    }
                                }
                            ]
                        },
                        {
                            field: 'buttons', title: __('事件日志'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.buttons, buttons: [
                                {
                                    name: 'detail',
                                    text: __('查看'),
                                    title: __('日志详情'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa',
                                    url: './eventlog/index?id={id}',
                                    callback: function (data) {

                                    },
                                    visible: function (row) {
                                        return true;
                                    }
                                }
                            ]
                        },
                        {
                            field: 'buttons', title: __('监测数据'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.buttons, buttons: [
                                {
                                    name: 'detail',
                                    text: __('监测'),
                                    title: __('监测数据'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa',
                                    url: './monitor/index',
                                    callback: function (data) {

                                    },
                                    visible: function (row) {
                                        return true;
                                    }
                                }
                            ]
                        },
                        { field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate }
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
                    index_url: 'device/list' + location.search,
                    add_url: 'device/add',
                    edit_url: 'device/edit',
                    del_url: 'device/del',
                    multi_url: 'device/multi',
                    import_url: 'device/import',
                    table: 'device',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        { checkbox: true },
                        { field: 'id', title: __('设备编号') },
                        { field: 'name', title: __('设备名称'), operate: 'LIKE' },
                        { field: 'product_id', title: __('所属产品'), operate: 'LIKE' },
                        { field: 'version', title: __('固件版本'), operate: 'BETWEEN' },
                        { field: 'image', title: __('设备图片'), operate: false, events: Table.api.events.image, formatter: Table.api.formatter.image },
                        { field: 'deviceswitch', title: __('Deviceswitch'), searchList: { "1": __('Yes'), "0": __('No') }, table: table, formatter: Table.api.formatter.toggle },
                        { field: 'shadowswitch', title: __('Shadowswitch'), searchList: { "1": __('Yes'), "0": __('No') }, table: table, formatter: Table.api.formatter.toggle },
                        { field: 'content', title: __('简介'), operate: false, formatter: Table.api.formatter.content },
                        { field: 'createtime', title: __('Createtime'), operate: 'RANGE', addclass: 'datetimerange', autocomplete: false, formatter: Table.api.formatter.datetime },
                        { field: 'longitude', title: __('Longitude'), operate: 'LIKE' },
                        { field: 'latitude', title: __('Latitude'), operate: 'LIKE' },
                        {
                            field: 'buttons', title: __('设备日志'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.buttons, buttons: [
                                {
                                    name: 'detail',
                                    text: __('查看日志'),
                                    title: __('日志详情'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa fa-list',
                                    url: './devicelog/index',
                                    callback: function (data) {

                                    },
                                    visible: function (row) {
                                        return true;
                                    }
                                }
                            ]
                        },
                        {
                            field: 'buttons', title: __('监测数据'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.buttons, buttons: [
                                {
                                    name: 'detail',
                                    text: __('监测数据'),
                                    title: __('监测数据'),
                                    classname: 'btn btn-primary btn-xs btn-dialog',
                                    icon: 'fa fa-list',
                                    url: './monitor/index',
                                    callback: function (data) {

                                    },
                                    visible: function (row) {
                                        return true;
                                    }
                                }
                            ]
                        },
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
