<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="PokeDexWeb._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Style/attr-span.css" rel="stylesheet" />
    <asp:Literal ID="jsDeclare" runat="server" ClientIDMode="Static"></asp:Literal>
    <script type="text/javascript">
        var app1;

        Vue.directive('img', function (el, url) {
            var img = new Image();
            img.src = url.value;

            img.onload = function () {
                el.src = url.value;
                $(el).css('opacity', 0).animate({ opacity: 1 }, 1000);
            }.bind();
        });

        window.onload = function () {
            var activeBtn = document.getElementById('nav-list');
            activeBtn.className = 'active';

            app1 = new Vue({
                el: '#pm_item',
                data: {
                    pm_list: pm_list,
                    gen: 0,
                }
            });

            document.getElementById('listBoard').style.display = null;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" id="pm_item">
        <div class="col-xs-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-default active" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_all" value="0" v-model="gen" checked="checked" />
                            全部
                        </label>
                        <label class="btn btn-default" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_1" value="1" v-model="gen" />
                            第一世代
                        </label>
                        <label class="btn btn-default" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_2" value="2" v-model="gen" />
                            第二世代
                        </label>
                        <label class="btn btn-default" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_3" value="3" v-model="gen" />
                            第三世代
                        </label>
                        <label class="btn btn-default" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_4" value="4" v-model="gen" />
                            第四世代
                        </label>
                        <label class="btn btn-default" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_5" value="5" v-model="gen" />
                            第五世代
                        </label>
                        <label class="btn btn-default" onclick="this.childNodes[0].click();">
                            <input type="radio" name="generation" id="gen_6" value="6" v-model="gen" />
                            第六世代
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div id="listBoard" style="display: none;">
            <div class="col-xs-6 col-sm-4 col-lg-2" v-for="pm_data in pm_list" v-if="gen == 0 ? true : pm_data.Gen == gen">
                <div class="thumbnail">
                    <a v-bind:href="'/dex.aspx?n=' + parseInt(pm_data.Num).toString()">
                        <div class="caption">
                            <h3 class="no-margin">No.{{ pm_data.Num }}</h3>
                        </div>
                        <img src="/Images/loading.gif" v-img="pm_data.ImgUrl" />
                        <div class="caption">
                            <p>{{ pm_data.Name }}</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
