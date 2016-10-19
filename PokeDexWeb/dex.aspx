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
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <ol class="breadcrumb" style="position: fixed; top: 70px; z-index: 1029;">
            <li></li>
            <li class="active">
                <asp:Label ID="lblNameCHT" runat="server" Text="妙蛙種子" ClientIDMode="Static"></asp:Label>
            </li>
        </ol>
        <!-- col-md-3 -->
        <div class="col-xs-12 col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">型態變化</div>
                <div class="panel-body">
                    <div class="form-group">
                        <asp:DropDownList ID="ddlForme" runat="server" CssClass="selectpicker form-control" ClientIDMode="Static">
                            <asp:ListItem Selected="True" Value="normal">妙蛙種子</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="thumbnail no-margin">
                        <asp:Image ID="imgProfile" runat="server" ImageUrl="Images/Dex/001.png" ClientIDMode="Static" />
                    </div>
                </div>
            </div>
            <!-- 基本資料 -->
            <div class="panel panel-default">
                <div class="panel-heading">基本資料</div>
                <table class="table table-bordered">
                    <tr>
                        <td class="status-title">圖鑑編號</td>
                        <td>
                            <asp:Label ID="lblNationalNumber" runat="server" Text="001" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="status-title">日文名</td>
                        <td>
                            <asp:Label ID="lblNameJPN" runat="server" Text="フシキダネ" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="status-title">英文名</td>
                        <td>
                            <asp:Label ID="lblNameENG" runat="server" Text="Bulbasaur" ClientIDMode="Static"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="status-title">屬性</td>
                        <td style="padding: 0px;">
                            <table class="table attribute no-margin">
                                <tr>
                                    <td class="attribute"><span class="pokemon-attributes background-color-grass">草</span></td>
                                    <td class="attribute"><span class="pokemon-attributes background-color-poison">毒</span></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="status-title">身高</td>
                        <td>0.7m</td>
                    </tr>
                    <tr>
                        <td class="status-title">體重</td>
                        <td>6.9kg</td>
                    </tr>
                </table>
            </div>
            <!-- 蛋 -->
            <div class="panel panel-default">
                <div class="panel-heading">蛋相關</div>
                <table class="table table-bordered">
                    <tr>
                        <td class="status-title">孵化步數</td>
                        <td>5120步</td>
                    </tr>
                    <tr>
                        <td class="status-title">蛋群</td>
                        <td>怪獸類、植物類</td>
                    </tr>
                </table>
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
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="255" style="width: 17.6%;">
                                    <span class="sr-only">45</span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">45</td>
                        <td class="stats-value"></td>
                    </tr>
                    <tr>
                        <td class="type">攻擊</td>
                        <td>
                            <div class="progress no-margin">
                                <div class="progress-bar" role="progressbar" aria-valuenow="49" aria-valuemin="0" aria-valuemax="255" style="width: 19.2%;">
                                    <span class="sr-only">49</span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">49</td>
                        <td class="stats-value"></td>
                    </tr>
                    <tr>
                        <td class="type">防禦</td>
                        <td>
                            <div class="progress no-margin">
                                <div class="progress-bar" role="progressbar" aria-valuenow="49" aria-valuemin="0" aria-valuemax="255" style="width: 19.2%;">
                                    <span class="sr-only">49</span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">49</td>
                        <td class="stats-value"></td>
                    </tr>
                    <tr>
                        <td class="type">特攻</td>
                        <td>
                            <div class="progress no-margin">
                                <div class="progress-bar" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="255" style="width: 25.5%;">
                                    <span class="sr-only">65</span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">65</td>
                        <td class="stats-value">1</td>
                    </tr>
                    <tr>
                        <td class="type">特防</td>
                        <td>
                            <div class="progress no-margin">
                                <div class="progress-bar" role="progressbar" aria-valuenow="65" aria-valuemin="0" aria-valuemax="255" style="width: 25.5%;">
                                    <span class="sr-only">65</span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">65</td>
                        <td class="stats-value"></td>
                    </tr>
                    <tr>
                        <td class="type">速度</td>
                        <td>
                            <div class="progress no-margin">
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="255" style="width: 17.6%;">
                                    <span class="sr-only">45</span>
                                </div>
                            </div>
                        </td>
                        <td class="stats-value">45</td>
                        <td class="stats-value"></td>
                    </tr>
                </table>
            </div>
            <!-- 特性 -->
            <div class="panel panel-default">
                <div class="panel-heading">特性</div>
                <table class="table table-bordered ability">
                    <tr>
                        <th class="type">特性一</th>
                        <th class="name">茂盛</th>
                        <th class="name">しんりょく</th>
                        <th class="name">Overgrow</th>
                    </tr>
                    <tr>
                        <td colspan="4">HP剩下最大HP的1/3以下時，草系技能的威力變成1.5倍。</td>
                    </tr>
                    <tr>
                        <th class="type">隱藏特性</th>
                        <th>葉綠素</th>
                        <th>ようりょくそ</th>
                        <th>Chlorophyll</th>
                    </tr>
                    <tr>
                        <td colspan="4">晴天時，速度變成2倍。</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
