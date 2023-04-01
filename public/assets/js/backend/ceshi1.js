define(["jquery", "bootstrap", "backend", "table", "form"], function (
  $,
  undefined,
  Backend,
  Table,
  Form
) {
  var Controller = {
    index: function () {
      // 初始化表格参数配置
      Table.api.init({
        extend: {
          index_url: "ceshi1/index" + location.search,
          add_url: "ceshi1/add",
          edit_url: "ceshi1/edit",
          del_url: "ceshi1/del",
          multi_url: "ceshi1/multi",
          import_url: "ceshi1/import",
          table: "ceshi1",
        },
      })

      var table = $("#table")

      // 初始化表格
      table.bootstrapTable({
        url: $.fn.bootstrapTable.defaults.extend.index_url,
        pk: "id",
        sortName: "weigh",
        fixedColumns: true,
        fixedRightNumber: 1,
        columns: [
          [
            { checkbox: true },
            { field: "id", title: __("Id") },
            { field: "user_id", title: __("User_id") },
            { field: "user_ids", title: __("User_ids"), operate: "LIKE" },
            { field: "weigh", title: __("Weigh"), operate: false },
            {
              field: "updatetime",
              title: __("Updatetime"),
              operate: "RANGE",
              addclass: "datetimerange",
              autocomplete: false,
              formatter: Table.api.formatter.datetime,
            },
            {
              field: "createtime",
              title: __("Createtime"),
              operate: "RANGE",
              addclass: "datetimerange",
              autocomplete: false,
              formatter: Table.api.formatter.datetime,
            },
            {
              field: "status",
              title: __("Status"),
              searchList: { normal: __("Normal"), hidden: __("Hidden") },
              formatter: Table.api.formatter.status,
            },
            { field: "category_id", title: __("Category_id") },
            {
              field: "category_ids",
              title: __("Category_ids"),
              operate: "LIKE",
            },
            {
              field: "operate",
              title: __("Operate"),
              table: table,
              events: Table.api.events.operate,
              formatter: Table.api.formatter.operate,
            },
          ],
        ],
      })

      // 为表格绑定事件
      Table.api.bindevent(table)
    },
    recyclebin: function () {
      // 初始化表格参数配置
      Table.api.init({
        extend: {
          dragsort_url: "",
        },
      })

      var table = $("#table")

      // 初始化表格
      table.bootstrapTable({
        url: "ceshi1/recyclebin" + location.search,
        pk: "id",
        sortName: "id",
        columns: [
          [
            { checkbox: true },
            { field: "id", title: __("Id") },
            {
              field: "deletetime",
              title: __("Deletetime"),
              operate: "RANGE",
              addclass: "datetimerange",
              formatter: Table.api.formatter.datetime,
            },
            {
              field: "operate",
              width: "140px",
              title: __("Operate"),
              table: table,
              events: Table.api.events.operate,
              buttons: [
                {
                  name: "Restore",
                  text: __("Restore"),
                  classname: "btn btn-xs btn-info btn-ajax btn-restoreit",
                  icon: "fa fa-rotate-left",
                  url: "ceshi1/restore",
                  refresh: true,
                },
                {
                  name: "Destroy",
                  text: __("Destroy"),
                  classname: "btn btn-xs btn-danger btn-ajax btn-destroyit",
                  icon: "fa fa-times",
                  url: "ceshi1/destroy",
                  refresh: true,
                },
              ],
              formatter: Table.api.formatter.operate,
            },
          ],
        ],
      })

      // 为表格绑定事件
      Table.api.bindevent(table)
    },

    add: function () {
      Controller.api.bindevent()
    },
    edit: function () {
      Controller.api.bindevent()
    },
    create: function () {
      Controller.api.bindevent()
    },
    image_result: function () {
      setInterval(() => {
        if (Config.status == "PROCESSING") {
          location.reload()
        }
      }, 1000)

    },
    createimagetext: function () {
      $.validator.config({
        rules: {
            diyname: function (element) {
                //如果直接返回文本，则表示失败的提示文字
                //如果返回true表示成功
                //如果返回Ajax对象则表示远程验证
                if (!element.value.toString().match(0,1)) {
                    return '请输入0-1之间的值';
                }

            }
        }
    })
      Controller.api.bindevent()
    },
    api: {
      bindevent: function () {
        Form.api.bindevent(
          $("form[role=form]"),
          function (data, ret) {
            console.log("success", data, ret)
            if (ret.code == 1 && ret.msg == "文生图成功") {
              // location.href='imageResult?id='+data;
              window.open(
                "image_result?id=" + data.jobId + "&number=" + data.number
              )
            }
            if (ret.code == 1 && ret.msg == "图文生图成功") {
              window.open(
                "image_result?id=" + data.jobId + "&number=" + data.number
              )
            }
          },
          function (data, ret) {
            console.log("error", data, ret)
          }
        )
      },
    },
  }
  return Controller
})
