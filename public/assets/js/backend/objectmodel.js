define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    function currencyFormatter(value){
        const jsonstring=value.replace(/&quot;/g, '"');
        const jsondata=JSON.parse(jsonstring);        
        
        if(jsondata.type=='bool'){
            return '0：'+jsondata.falseText+"\n"+'1：'+jsondata.trueText;
        }
        if(jsondata.type=='string'){
            return '最大长度：'+jsondata.maxLength;
        }
        if(jsondata.type=='array'){
            return '数据类型：'+jsondata.arrayType+"   "+'元素个数：'+jsondata.arrayCount;
        }
        if(jsondata.type=='integer'||jsondata.type==='decimal'){
            return '最大值：'+jsondata.max+"   "+'最小值：'+jsondata.min+'\n'+
            '步长：'+jsondata.step+"   "+'单位：'+jsondata.unit;
        }
        if(jsondata.type=='enum'){
            let enumstring="";
            for(var i=0;i<jsondata.enumList.length;i++){
                enumstring+=jsondata.enumList[i].value+"："+jsondata.enumList[i].text+'\n';
            }
            return enumstring;
        }
        if(jsondata.type=='object'){
            let enumstring="";
            for(var i=0;i<jsondata.objecttype.length;i++){
                const objectname=jsondata.objecttype[i].objectname;
                const datatypeType = JSON.parse(jsondata.objecttype[i].datatype).type
                enumstring+=objectname+"："+datatypeType+'\n';
            }
            return enumstring;
        }
        console.log(jsondata);
    }

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'objectmodel/index' + location.search,
                    add_url: 'objectmodel/add',
                    edit_url: 'objectmodel/edit',
                    del_url: 'objectmodel/del',
                    multi_url: 'objectmodel/multi',
                    import_url: 'objectmodel/import',
                    table: 'objectmodel',
                }
            });

            var table = $("#table");
            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'weigh',
                fixedColumns: true,
                fixedRightNumber: 1,
                columns: [
                    [
                        {checkbox: true},    
                        {field: 'name', title: __('Name'), operate: 'LIKE'},
                        {field: 'identifier', title: __('标识符'), operate: 'LIKE'},                        
                        {field: 'tag', title: __('物模型类别'), operate: 'LIKE', formatter: Table.api.formatter.flag},
                        {field: 'readswitch', title: __('Readswitch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'chartswitch', title: __('Chartswitch'), searchList: {"1":__('Yes'),"0":__('No')}, table: table, formatter: Table.api.formatter.toggle},
                        {field: 'datatype', title: __('数据类型'), operate: 'LIKE'},
                        {field: 'definition', title: __('数据定义'),formatter:currencyFormatter},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', autocomplete:false, formatter: Table.api.formatter.datetime},
                        {field: 'weigh', title: __('Weigh'), operate: false},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Form.api.bindevent($("#add-form"));
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
