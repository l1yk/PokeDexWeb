<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="dex.aspx.cs" Inherits="PokeDexWeb.dex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- My stylesheet -->
    <link href="Style/attr-span.css" rel="stylesheet" />
    <style type="text/css">
        body {
            padding-top: 126px;
        }

        td.status-title {
            background-color: #30a7d7;
            color: #FFF;
            text-align: center;
            width: 40%;
        }

        table.stats th {
            background-color: #87c3e8;
            text-align: center;
        }

        table.stats td.type {
            background-color: #a4a4a4;
            text-align: center;
            width: 15%;
        }

        table.stats td.stats-value {
            text-align: center;
            width: 15%;
        }

        table.ability th.type {
            background-color: #87c3e8;
            text-align: center;
            width: 25%;
        }

        table.ability th.name {
            width: 25%;
        }

        table.attribute td.attribute {
            border: none;
            border-width: 0px;
            width: 50%;
        }
    </style>

    <script type="text/javascript">
        window.onload = function () {
            var activeBtn = document.getElementById('nav-dex');
            activeBtn.className = 'active';

            var tmpObj, tmpValueNow, tmpValueMax;

            VisualizeStats('divValueBarHP');
            VisualizeStats('divValueBarAttack');
            VisualizeStats('divValueBarDefence');
            VisualizeStats('divValueBarSpAttack');
            VisualizeStats('divValueBarSpDefence');
            VisualizeStats('divValueBarSpeed');

            $('#ddlForme').on('change', function () {
                var pokeNum = parseInt($('#lblNationalNumber').html());
                var forme = $('#ddlForme').find(':selected').val();
                var tmpURL = '/dex.aspx?' + encodeURI('n=' + pokeNum.toString() + '&forme=' + forme);
                window.open(tmpURL, '_self');
            });
        }

        function VisualizeStats(id) {
            tmpObj = document.getElementById(id);
            tmpValueNow = parseFloat(tmpObj.attributes.getNamedItem('aria-valuenow').value);
            tmpValueMax = parseFloat(tmpObj.attributes.getNamedItem('aria-valuemax').value);
            tmpObj.style.width = ((tmpValueNow / tmpValueMax) * 100).toFixed(2) + '%';
            tmpObj.className = 'progress-bar';
            if (tmpValueNow >= 100) tmpObj.classList.add('progress-bar-success');
            else if (tmpValueNow <= 50 && tmpValueNow > 20) tmpObj.classList.add('progress-bar-warning');
            else if (tmpValueNow <= 20) tmpObj.classList.add('progress-bar-danger');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <ol class="breadcrumb" style="position: fixed; top: 70px; z-index: 1029; margin-left: auto; margin-right: auto;">
            <li>
                <asp:HyperLink ID="linkPrevious" runat="server" ClientIDMode="Static" Visible="False">[Previous]</asp:HyperLink>
            </li>
            <li class="active">
                <asp:Label ID="lblNameCHT" runat="server" ClientIDMode="Static"></asp:Label>
            </li>
            <li>
                <asp:HyperLink ID="linkNext" runat="server" ClientIDMode="Static" Visible="False">[Next]</asp:HyperLink>
            </li>
        </ol>
        <!-- col-md-3 -->
        <div class="col-xs-12 col-md-3 no-padding">
            <div class="col-xs-12 col-sm-6 col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">型態變化</div>
                    <div class="panel-body">
                        <div class="form-group" id="ddlPanel" runat="server" clientidmode="static">
                            <asp:DropDownList ID="ddlForme" runat="server" CssClass="selectpicker form-control" ClientIDMode="Static" AutoPostBack="False">
                            </asp:DropDownList>
                        </div>
                        <div class="thumbnail no-margin">
                            <asp:Image ID="imgProfile" runat="server" ClientIDMode="Static" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- 基本資料 -->
            <div class="col-xs-12 col-sm-6 col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">基本資料</div>
                    <table class="table table-bordered">
                        <tr>
                            <td class="status-title">圖鑑編號</td>
                            <td>
                                <asp:Label ID="lblNationalNumber" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">日文名</td>
                            <td>
                                <asp:Label ID="lblNameJPN" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">英文名</td>
                            <td>
                                <asp:Label ID="lblNameENG" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">屬性</td>
                            <td style="padding: 0px;">
                                <table class="table attribute no-margin">
                                    <tr>
                                        <td class="attribute">
                                            <asp:Label ID="lblType1" runat="server" ClientIDMode="Static"></asp:Label>
                                        </td>
                                        <td class="attribute">
                                            <asp:Label ID="lblType2" runat="server" ClientIDMode="Static"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">身高</td>
                            <td>
                                <asp:Label ID="lblHeight" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">體重</td>
                            <td>
                                <asp:Label ID="lblWeight" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">♂:♀</td>
                            <td>
                                <asp:Label ID="lblGenderRatio" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- 蛋 -->
                <div class="panel panel-default">
                    <div class="panel-heading">蛋相關</div>
                    <table class="table table-bordered">
                        <tr>
                            <td class="status-title">孵化步數</td>
                            <td>
                                <asp:Label ID="lblHatchCount" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="status-title">蛋群</td>
                            <td>
                                <asp:Label ID="lblEggGroup" runat="server" ClientIDMode="Static"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!-- col-md-9 -->
        <div class="col-xs-12 col-md-9" id="content">
            <!-- 數值 -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    數值資料
                </div>
                <table class="table table-bordered stats">
                    <tr>
                        <th>能力</th>
                        <th colspan="2">種族值</th>
                        <th>努力值</th>
                    </tr>
                    <tr>
                        <td class="type">HP</td>
                        <td>
                            <div class="progress no-margin">
                                <div id="divValueBarHP" class="progress-bar" role="progressbar" runat="server" clientidmode="Static" aria-valuemin="0" aria-valuemax="255">
                                    <span class="sr-only"></span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblStatsHP" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblEVsHP" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="type">攻擊</td>
                        <td>
                            <div class="progress no-margin">
                                <div id="divValueBarAttack" class="progress-bar" role="progressbar" runat="server" clientidmode="Static" aria-valuemin="0" aria-valuemax="255">
                                    <span class="sr-only"></span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblStatsAttack" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblEVsAttack" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="type">防禦</td>
                        <td>
                            <div class="progress no-margin">
                                <div id="divValueBarDefence" class="progress-bar" role="progressbar" runat="server" clientidmode="Static" aria-valuemin="0" aria-valuemax="255">
                                    <span class="sr-only"></span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblStatsDefence" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblEVsDefence" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="type">特攻</td>
                        <td>
                            <div class="progress no-margin">
                                <div id="divValueBarSpAttack" class="progress-bar" role="progressbar" runat="server" clientidmode="Static" aria-valuemin="0" aria-valuemax="255">
                                    <span class="sr-only"></span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblStatsSpAttack" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblEVsSpAttack" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="type">特防</td>
                        <td>
                            <div class="progress no-margin">
                                <div id="divValueBarSpDefence" class="progress-bar" role="progressbar" runat="server" clientidmode="Static" aria-valuemin="0" aria-valuemax="255">
                                    <span class="sr-only"></span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblStatsSpDefence" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblEVsSpDefence" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="type">速度</td>
                        <td>
                            <div class="progress no-margin">
                                <div id="divValueBarSpeed" class="progress-bar" role="progressbar" runat="server" clientidmode="Static" aria-valuemin="0" aria-valuemax="255">
                                    <span class="sr-only"></span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblStatsSpeed" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                        <td class="stats-value">
                            <asp:Label ID="lblEVsSpeed" runat="server" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- 特性 -->
            <div class="panel panel-default">
                <div class="panel-heading">特性</div>
                <asp:Table ID="tableAbility" runat="server" ClientIDMode="Static" CssClass="table table-bordered ability"></asp:Table>
            </div>
        </div>
    </div>
</asp:Content>
