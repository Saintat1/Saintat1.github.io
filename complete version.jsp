<div class="row">
	<div class="panel">
		<div class="panel-heading">
			<span class="panel-title">
				<a data-toggle="collapse" data-target="#perf-option-header" href="#perf-option-header">Options</a>
			</span>
		</div>
		<div id="perf-option-header" class="panel-collapse collapse in">
		<div class="panel-body">
			<form id="trade_form" class="form-inline">	

				<input type="hidden" name="trade_tags" id="trade_tags"/>

				<div class="col-md-10"> 
					<table class="table table-no-bordered">
						<tbody>
							<tr>
								<td>
									Instrument Type
								</td>
								<td align="left">
									<select class="form-control form-group-margin" style="width:100" id="instrument_type" name="instrument_type">
										<option value="Futures">Futures</option>
										<option value="Options">Options</option>
									</select>
									
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Start Date&nbsp;
									<input class="form-control form-padding" style="width:100" type="text" id="trade_startDate" name="trade_startDate" value=""/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End Date&nbsp;
									<input class="form-control form-padding" style="width:100" type="text" id="trade_endDate" name="trade_endDate" value=""/>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tags
									
									<select class="chosen" multiple="true" style="width: 20%;" id="trade-tag-input" data-placeholder="Select tags...">
										<c:forEach items="${tagList}" var="tag">
											<option value="'${tag}'">${tag}</option>
											</c:forEach> 
									</select>
									
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div class="checkbox">
										<label>
											<input type="checkbox" value="" class="px" id="trade-all-tags" checked>
											<span class="lbl">All Tags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
										</label>
									</div> 
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" class="btn btn-primary" id="daily-summary-search"
										data-loading-text="<span class='fa fa-refresh glyphicon-refresh-animate'></span>&nbsp;Loading...">&nbsp;&nbsp;Search&nbsp;&nbsp;
								</button>
								</td>
								</tr>
						</tbody>
					</table>

					<div style="display:none; color:red; text-align:left" id="trade-error-message">Please select trader and tag</div>

				</div>
			</form>
		</div>
	</div>
</div>
</div>
<div class="row" id="trade_separator"><br><br></div>
	

<div class="col-sm-12" id="total_panel" style="display:none;">   
	<ul id="uidemo-tabs-default-demo" class="nav nav-tabs">
			<li class="active"><a href="#uidemo-tabs-default-demo-dropdown1"
				data-toggle="tab">Future</a></li>
			<li><a href="#uidemo-tabs-default-demo-dropdown2"
				data-toggle="tab">Option</a></li>
	</ul>
	
	
	<div class="tab-content tab-content-bordered" style="background:white;">	
	<div class="tab-pane tab-pane-reporting fade active in" id="uidemo-tabs-default-demo-dropdown1"> 
	<div  id="trade_summary_futures" style="padding-top:9" style="display:none;">
	<div class="panel">
		<div class="panel-heading">
			<span class="panel-title">Settled Position</span>  <!-- Stats, Trend buttons -->
			<div class="panel-heading-controls">
				<div class="btn-group btn-group-sm"> 
					<button type="button" class="btn btn-xs btn-primary" id="trade_buttonGroup_stats_futures">Daily History</button>
					<button type="button" class="btn btn-xs btn-info" id="trade_buttonGroup_pnlTrend_futures">PnL Trend</button>
					<button class="btn btn-xs btn-labeled btn-default" id="trade_summary_download_futures">Download</button>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<div class="row span550" id="trade_summary_stats_all_closed_futures" >
				<table class="table table-striped table-reporting table-reporting-left table-hover table-scrollable">
					<thead>   
						<tr class="table-reporting-title-color"> 
							<td style="padding-right:100px;">PnL Date</td>
							<td style="padding-right:200px;">Henry Hub (Natural Gas)</td>
							<td style="padding-right:200px;">ERCOT North 345KV Hub</td>
							<td style="padding-right:200px;">PJM Western Hub</td>
							<td style="padding-right:200px;">ERCOT Houston 345KV Hub</td>
							<td style="padding-right:200px;">Total</td>
						</tr>
						</thead>
					<tbody id='trade_summary_stats_all_tbody_closed_futures'>
					</tbody>
				</table>
			</div>
			<div id="trade_summary_pnlTrend_all_futures">
				<div class="col-md-12"><div id="pnlAllChart_market_futures"></div></div>
				<div class="col-md-12"><div id="pnlAllChart_all_futures"></div></div>
			</div>
			
		</div>
		</div>
		<div class="panel">
		<div class="panel-heading">
			<span class="panel-title">OPEN Position</span>  <!-- Stats, Trend buttons -->
		</div>
		<div class="panel-body">
			<div class="row span300" id="trade_summary_stats_all_open_futures" >
				<table class="table table-striped table-reporting table-reporting-left table-hover ">
					<thead>   
						<tr class="table-reporting-title-color"> 
						
							<td style="padding-right:100px;">Date</td>
							<td style="padding-right:200px;">Henry Hub (Natural Gas)</td>
							<td style="padding-right:200px;">ERCOT North 345KV Hub</td>
							<td style="padding-right:200px;">PJM Western Hub</td>
							<td style="padding-right:200px;">ERCOT Houston 345KV Hub</td>
							<td style="padding-right:200px;">Total</td>
						</tr>
						</thead>
					<tbody id='trade_summary_stats_all_tbody_open_futures'>
					</tbody>
				</table>
			</div>
		</div>
		</div>
	</div>
	</div>
	
	<div class="tab-pane tab-pane-reporting fade" id="uidemo-tabs-default-demo-dropdown2">
		<div id="trade_summary_options"> 
			<div id="daily-summary-result">					
				<div id="position-PnLSummary-tab">
				</div>
			</div>
		</div>
	</div>
</div>
	
</div>


<script>

// date array for chart
var dateArr;
// chart arrays
var pnlTotalArr, pnlIncsArr, pnlDecsArr,pnlNetArr;  // daily
var pnlTotalArrCum, pnlIncsArrCum, pnlDecsArrCum, pnlNetArrCum;  // cumulative
// chart arrays - ALL
var pnlTotalArr_pjm = [], pnlTotalArr_ercot_north = [],pnlTotalArr_naturalGas = [],pnlTotalArr_ercot_houston = []; 
var pnlTotalArrCum_pjm = [], pnlTotalArrCum_ercot_north = [],pnlTotalArrCum_naturalGas=[],pnlTotalArrCum_ercot_houston = []; 
var pnlTotalArrCum_total = [], pnlTotalArrCum_net = []; 

var colorArray = ['#00285E','#6AF9C4', '#FFF263', '#D1BBB0', '#FF9393', '#B2E895','#6479A1','#7DC3AE','#89BCBE', '#BFCFCE', '#6479A1'];

$('#daily-summary-search').click(function() {

	if($('#trade_form').valid()) {

		if(
			( $('#trade-all-tags').is(':checked') || $('#trade-tag-input').val() )  
			) {
			$('#trade_separator').hide();
			$('#trade-error-message').hide();
			var $btn = $('#daily-summary-search').button('loading');
	
			$('#trade_tags').val(formatFormTags( $('#trade-all-tags'), $('#trade-tag-input'), '${tagList}' ));
		
			dateArr = [];     

				$.ajax({
					url : 'reportAction_geaPnLReport_closed_futures.action',
					type : 'GET',
					async : true, 
					data : $('#trade_form').serialize(),
					dataType: "html",   // here we use jsonString from server
					error : function(xhr, status, error) {
						//console.log(status + '  ' + error);
						//console.log(xhr.responseText);
						$btn.button('reset');
					},
					success : function(data) {
						var table_html = '';
						var tradeHistoryAll = $.parseJSON(data);
						if(tradeHistoryAll === '' || tradeHistoryAll.length === 0) {
							table_html += '<tr><td>No record found!</td></tr>';
						}
						else {
							// for open positions
							openHenryHub = tradeHistoryAll[2].HenryHub.pnl;
							openERCOTNorth345KVHub = tradeHistoryAll[2].ERCOTNorth345KVHub.pnl;
							openERCOTHouston345KVHub = tradeHistoryAll[2].ERCOTHouston345KVHub.pnl;
							openPJMWesternHub = tradeHistoryAll[2].PJMWesternHub.pnl;
							opentotal = openHenryHub + openERCOTNorth345KVHub + openERCOTHouston345KVHub + openPJMWesternHub;
					 		var now = new Date();
					 		var day = ("0" + now.getDate()).slice(-2);
					         var month = ("0" + (now.getMonth() + 1)).slice(-2);
					         var nowStr = now.getFullYear()+"-"+(month)+"-"+(day) ;

							Ohtml = '<tr><td>' + nowStr + '</td>';
							
							if(openHenryHub < 0) Ohtml += '<td style="color:red;font-size:120%;font-weight:bold">' + format(openHenryHub,2,true) + '</td>';
							else Ohtml += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(openHenryHub,2,true) + '</td>';
							
							if(openERCOTNorth345KVHub < 0) Ohtml += '<td style="color:red;font-size:120%;font-weight:bold">' + format(openERCOTNorth345KVHub,2,true) + '</td>';
							else Ohtml += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(openERCOTNorth345KVHub,2,true) + '</td>';
							
							if(openERCOTHouston345KVHub < 0) Ohtml += '<td style="color:red;font-size:120%;font-weight:bold">' + format(openERCOTHouston345KVHub,2,true) + '</td>';
							else Ohtml += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(openERCOTHouston345KVHub,2,true) + '</td>';
							
							if(openPJMWesternHub < 0) Ohtml += '<td style="color:red;font-size:120%;font-weight:bold">' + format(openPJMWesternHub,2,true) + '</td>';
							else Ohtml += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(openPJMWesternHub,2,true) + '</td>';
							
							if(opentotal < 0) Ohtml += '<td style="color:red;font-size:120%;font-weight:bold">' + format(opentotal,2,true) + '</td>';
							else Ohtml += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(opentotal,2,true) + '</td><tr>';
							pnlTotalArr_pjm = [], pnlTotalArr_ercot_north = [],pnlTotalArr_naturalGas = [], pnlTotalArr_ercot_houston = []; 
							pnlTotalArrCum_pjm = [], pnlTotalArrCum_ercot_north = [],pnlTotalArrCum_naturalGas = [], pnlTotalArrCum_ercot_houston = [];
							pnlTotalArrCum_total = [], pnlTotalArrCum_net = [];

							
							
							var pnlTotalCum_pjm = 0,
							    pnlTotalCum_naturalGas =0,
								pnlTotalCum_ercot_north = 0;
								pnlTotalCum_ercot_houston = 0;
							
							var pnlpjm = 0,
							    pnlnaturalGas =0,
							    pnlercotnorth = 0;
								pnlercothouston = 0;
							
							var ticketTotal_ercot_north = 0;
							var ticketTotal_pjm = 0;
							var ticketTotal_naturalGas = 0;
							var ticketTotal_ercot_houston = 0;
							
							var buyTotal_ercot_north = 0;
							var buyTotal_pjm = 0;
							var buyTotal_naturalGas = 0;
							var buyTotal_ercot_houston = 0;
							
							var sellTotal_ercot_north = 0;
							var sellTotal_pjm = 0;
							var sellTotal_naturalGas = 0;
							var sellTotal_ercot_houston = 0;
							for ( n = 0; n < tradeHistoryAll[1].length; n++){
								var name =tradeHistoryAll[1][n].toString();
								var totalPnlPerDay = 0;
								var netPnlPerDay = 0;
								
								 $.each(tradeHistoryAll[0], function(i,obj) {
									 if (tradeHistoryAll[1][n]==i){
									    var day = i;
										dateArr.push(day);
										pnlpjm += obj.PJMWesternHub.pnl;
										pnlnaturalGas += obj.HenryHub.pnl;
										pnlercotnorth += obj.ERCOTNorth345KVHub.pnl;
										pnlercothouston += obj.ERCOTHouston345KVHub.pnl;
										
										table_html += '<tr>';
										table_html += '<td style="padding-left:10px;">' + day + '</td>';
										
										
										var order = ["HenryHub", "ERCOTNorth345KVHub", "PJMWesternHub","ERCOTHouston345KVHub"];
										//console.log(order);
										var sortedMarkets = _.sortBy(obj,function(object){ 
										    return _.indexOf(order, object.hub);
										});
										$.each(sortedMarkets, function(i, oneMarket) {
											var market = oneMarket.hub;
											var totalPnl = oneMarket.pnl;
											var netPnl = oneMarket.pnl;
											
											totalPnlPerDay += totalPnl;
											netPnlPerDay += totalPnl;
											if(market === 'PJM Western Hub') {
												pnlTotalCum_pjm += totalPnl;
												pnlTotalArr_pjm.push(totalPnl);
												pnlTotalArrCum_pjm.push(pnlTotalCum_pjm);
											}
											else if(market === 'ERCOT North 345KV Hub') {
												pnlTotalCum_ercot_north += totalPnl;
												pnlTotalArr_ercot_north.push(totalPnl);
												pnlTotalArrCum_ercot_north.push(pnlTotalCum_ercot_north);
											}
											else if(market === 'Henry Hub') {
												pnlTotalCum_naturalGas += totalPnl;
												pnlTotalArr_naturalGas.push(totalPnl);
												pnlTotalArrCum_naturalGas.push(pnlTotalCum_naturalGas);
											}else{
												pnlTotalCum_ercot_houston += totalPnl;
												pnlTotalArr_ercot_houston.push(totalPnl);
												pnlTotalArrCum_ercot_houston.push(pnlTotalCum_ercot_houston);
											}
											var totalPnlFormat = format(totalPnl,2,true);
											var netPnlFormat = format(netPnl,2, true);
											if(totalPnl < 0) table_html += '<td style="color:red">' + totalPnlFormat + '</td>';
											else table_html += '<td style="color:LimeGreen">' + totalPnlFormat + '</td>';
										});
										pnlTotalArrCum_total.push(0);
										pnlTotalArrCum_net.push(0);
										var totalPnlPerDayFormat = format(totalPnlPerDay,2,true);
										var netPnlPerDayFormat = format(netPnlPerDay,2,true);
										if(totalPnlPerDay < 0) table_html += '<td style="color:red">' + totalPnlPerDayFormat + '</td>';
										else table_html += '<td style="color:LimeGreen">' + totalPnlPerDayFormat + '</td>';
										table_html += '</tr>';
										
										
										
									 }
								 })
							}
							//Total row
							var total_total = pnlpjm + pnlnaturalGas + pnlercotnorth + pnlercothouston;
							table_html += '<tr>';
							table_html += '<td style="padding-left:10px;font-size:120%;font-weight:bold">' + 'Total' + '</td>';
							if(pnlTotalCum_naturalGas < 0) table_html += '<td style="color:red;font-size:120%;font-weight:bold">' + format(pnlTotalCum_naturalGas,2,true) + '</td>';
							else table_html += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(pnlTotalCum_naturalGas,2,true) + '</td>';
							if(pnlTotalCum_ercot_north < 0) table_html += '<td style="color:red;font-size:120%;font-weight:bold">' + format(pnlTotalCum_ercot_north,2,true) + '</td>';
							else table_html += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(pnlTotalCum_ercot_north,2,true) + '</td>';
							if(pnlTotalCum_pjm < 0) table_html += '<td style="color:red;font-size:120%;font-weight:bold">' + format(pnlTotalCum_pjm,2,true) + '</td>';
							else table_html += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(pnlTotalCum_pjm,2,true) + '</td>';
							if(pnlTotalCum_ercot_houston < 0) table_html += '<td style="color:red;font-size:120%;font-weight:bold">' + format(pnlTotalCum_ercot_houston,2,true) + '</td>';
							else table_html += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(pnlTotalCum_ercot_houston,2,true) + '</td>';
							if(total_total < 0) table_html += '<td style="color:red;font-size:120%;font-weight:bold">' + format(total_total,2,true) + '</td>';
							else table_html += '<td style="color:LimeGreen;font-size:120%;font-weight:bold">' + format(total_total,2,true) + '</td>';
							table_html += '</tr>';
						}
						$('#trade_summary_stats_all_tbody_closed_futures').html(table_html);
						$('#trade_summary_stats_all_tbody_open_futures').html(Ohtml);
						$('#trade_summary_stats').hide();
						$('#trade_summary_pnlTrend').hide();
						$('#trade_summary_pnlTrend_all_futures').hide();
						$('#trade_summary_stats_all_closed_futures').show();
						$('#trade_summary_stats_all_open_futures').show();
						}
				});
			
				if($('#trade_startDate').val() > $('#trade_endDate').val()){
					alert('Start date must be earlier than end date.');
					return;
				}
				
				$('#trade-error-message').hide();
				$('#trader-input').prop('disabled', true);
				$('#position-PnLSummary-tab').empty();
		        pnlTemplate("'GEA-Fundamental'", 'ppa');	   ////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		        
		        $('#daily-summary-result').show();
		        $('#trade_summary_futures').show();
		        $('#trade_summary_options').show();
		        $('#total_panel').show();
		        $btn.button('reset');
			}else {
			$('#trade_separator').show();
			$('#trade-error-message').show();
		}
	}
});

function onTradeHistoryDateClick(target_date) { 
	$('#trade_cleared_tbody').empty();
	$('#trade_pnl_tbody').empty();
	$('#trade_price_tbody').empty();
	$('#detailsPanelTitle').text('Details (' + target_date + ')');  
	$('#trade_pnl').hide();
	$('#trade_price').hide();
	$('#trade_cleared').hide();
	$('#trade_detail').show();
	var loading = $('#trade_detail_panelBody').find(".overlay");
	loading.fadeIn();
	$.ajax({
		url:'reportAction_virtualReport_trade_getDetail.action',
		type : 'GET',
		data : $('#trade_form').serialize() + '&trade_targetDate=' + target_date,
		dataType : 'html',
		async : true,  
		error : function(xhr, status, error) {
			console.log(status + '  ' + error);
			console.log(xhr.responseText);
			$('#trade_cleared').show();
		},
		success : function(data) {
			var detail = $.parseJSON(data);
			var totalIncBidArr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		    totalDecBidArr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		    totalIncClearArr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		    totalDecClearArr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		    totalPnlArr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		    var html_history = '';
			var html_pnl = '';
			var html_price = '';
			$.each(detail, function(i, oneLoc) {
				var side = oneLoc.side;
				var node = oneLoc.node;
				html_history += '<tr>';
				html_history += '<td style="text-align:left">' +  node + '</td>';  
				html_pnl += '<tr>';
				html_pnl += '<td style="text-align:left">' +  node + '</td>';  
				html_price += '<tr>';
				html_price += '<td style="text-align:left">' +  node + '</td>'; 
				for(var i = 0; i < oneLoc.clearArr.length; i++) {
					// Position
					var bid = oneLoc.bidArr[i];
					var clear = oneLoc.clearArr[i];
					if(clear == 0) {
						html_history += '<td></td>'; 
					}
					else {
						if(side === 'DEC') {
							totalDecBidArr[i] += bid;
							totalDecClearArr[i] += clear;
							html_history += '<td class="heatmap_red">' +  format(clear, 1) + ' / ' + format(bid, 1) + '</td>';
						}
						else {
							totalIncBidArr[i] += bid;
							totalIncClearArr[i] += clear;
							html_history += '<td class="heatmap_green">' +  format(clear, 1) + ' / ' + format(bid, 1) + '</td>';
						}
					}
					// PnL
					var pnl = oneLoc.pnlArr[i];
					if(pnl === 0) {
						html_pnl += '<td></td>'; 
					}
					else {
						totalPnlArr[i] += pnl;
						if(pnl < 0)
							html_pnl += '<td style="color:red">' +  format(pnl) + '</td>';
						else 
							html_pnl += '<td style="color:LimeGreen">' +  format(pnl) + '</td>';
					}
					// Price
					var da = oneLoc.dalmpArr[i];
					var rt = oneLoc.rtlmpArr[i];
					var dart = da - rt;
					if(da != 0 && rt != 0) {
						if(dart < 0) { 
							html_price += '<td nowrap>' + format(da) + ' / ' + format(rt) + ' / ' + '<span style="color:red">' +  format(dart) + '</span></td>';
						}
						else {  
							html_price += '<td nowrap>' + format(da) + ' / ' + format(rt) + ' / ' + '<span style="color:LimeGreen">' +  format(dart) + '</span></td>';
						}
					} 
					else {
						html_price += '<td></td>';
					}

				}
				html_history += '</tr>';
				html_pnl += '</tr>';
				html_price += '</tr>';
			});

			var position_tbody = $('#trade_cleared_tbody');
			var pnl_tbody = $('#trade_pnl_tbody');
			
			// total inc row
			var $total_inc_tr = $('<tr>');
			$total_inc_tr.append('<td style="text-align:left; font-style: italic;">Total INC</td>');
			for(var i = 0; i < totalIncBidArr.length; i++) {

				var $td = $('<td>');
				var bid = totalIncBidArr[i],
				    clear = totalIncClearArr[i];

				if(clear != 0) {
					$td.text(format(clear, 1) + ' / ' + format(bid, 1));
					$td.addClass('heatmap_green');
					$td.attr('nowrap', 'nowrap');
				}

				$total_inc_tr.append($td);
			}
			position_tbody.append($total_inc_tr);

			// total dec row
			var $total_dec_tr = $('<tr>');
			$total_dec_tr.append('<td style="text-align:left; font-style: italic;">Total DEC</td>');
			for(var i = 0; i < totalDecBidArr.length; i++) {

				var $td = $('<td>');
				var bid = totalDecBidArr[i],
				    clear = totalDecClearArr[i];

				if(clear != 0) {
					$td.text(format(clear, 1) + ' / ' + format(bid, 1));
					$td.addClass('heatmap_red');
					$td.attr('nowrap', 'nowrap');
				}

				$total_dec_tr.append($td);
			}
			position_tbody.append($total_dec_tr);

			// total pnl
			var $total_pnl_tr = $('<tr>');
			$total_pnl_tr.append('<td style="text-align:left; font-style: italic;">Total PnL</td>');
			for(var i = 0; i < totalPnlArr.length; i++) {

				var $td = $('<td>');
				var pnl = totalPnlArr[i];

				if(pnl != 0) {
					$td.text(format(pnl,2,true));
					if(pnl < 0)
						$td.css('color', 'red');
					else 
						$td.css('color', 'LimeGreen');
				}

				$total_pnl_tr.append($td);
			}
			pnl_tbody.append($total_pnl_tr);
			$('#trade_cleared_tbody').append(html_history);
			$('#trade_pnl_tbody').append(html_pnl);
			$('#trade_price_tbody').html(html_price);
			loading.fadeOut(function() {
				$('#trade_cleared').show();
			});
		}
	});
}


$('#trade_buttonGroup_position').click(function() {
	$('#trade_pnl').hide();
	$('#trade_price').hide();
	$('#trade_cleared').show();
});
$('#trade_buttonGroup_pnl').click(function() {
	$('#trade_cleared').hide();
	$('#trade_price').hide();
	$('#trade_pnl').show();
});
$('#trade_buttonGroup_price').click(function() {
	$('#trade_cleared').hide();
	$('#trade_pnl').hide();
	$('#trade_price').show();
});  

$('#trade_buttonGroup_stats_futures').click(function() {
	if($('#instrument_type').val() === 'Futures') {
		$('#trade_summary_pnlTrend').hide();
		$('#trade_summary_stats').hide();
		$('#trade_summary_pnlTrend_all_futures').hide();
		$('#trade_summary_stats_all_closed_futures').show();
		$('#trade_summary_stats_all_open_futures').show();
	}
	else {
		$('#trade_summary_pnlTrend_all_futures').hide();
		$('#trade_summary_stats_all_closed_futures').hide();
		$('#trade_summary_stats_all_open_futures').hide();
		$('#trade_summary_pnlTrend').hide();
		$('#trade_summary_stats').show();
	}
});
$('#trade_buttonGroup_pnlTrend_futures').click(function() {
	if($('#instrument_type').val() === 'Futures') {
		$('#trade_summary_stats').hide();
		$('#trade_summary_pnlTrend').hide();
		$('#trade_summary_stats_all_closed_futures').hide();
		$('#trade_summary_stats_all_open_futures').hide();
		$('#trade_summary_pnlTrend_all_futures').show();
		// chart1
		var options1 = showLineBarChart("pnlAllChart_market_futures", "Total PnL by Market", dateArr); 
		options1.series.push( { color: colorArray[1], name: "ERCOT North", yAxis: 0, data: pnlTotalArr_ercot_north, type: "column", tooltip:{valueDecimals:2} } );
		options1.series.push( { color: colorArray[2], name: "PJM", yAxis: 0, data: pnlTotalArr_pjm, type: "column", tooltip:{valueDecimals:2} } );
		options1.series.push( { color: colorArray[2], name: "Natural Gas", yAxis: 0, data: pnlTotalArr_naturalGas, type: "column", tooltip:{valueDecimals:2} } );
		options1.series.push( { color: colorArray[2], name: "ERCOT Houston", yAxis: 0, data: pnlTotalArr_ercot_houston, type: "column", tooltip:{valueDecimals:2} } );
		
		options1.series.push( { color: colorArray[1], name: "ERCOT North Accum", yAxis: 1,data: pnlTotalArrCum_ercot_north, type: "line", tooltip:{valueDecimals:2} } ); 
		options1.series.push( { color: colorArray[2], name: "PJM Accum", yAxis: 1, data: pnlTotalArrCum_pjm, type: "line", tooltip:{valueDecimals:2} } ); 
		options1.series.push( { color: colorArray[3], name: "Natural Gas Accum", yAxis: 1, data: pnlTotalArrCum_naturalGas, type: "line", tooltip:{valueDecimals:2} } ); 
		options1.series.push( { color: colorArray[3], name: "ERCOT Houston Accum", yAxis: 1, data: pnlTotalArrCum_ercot_houston, type: "line", tooltip:{valueDecimals:2} } ); 
		
		var chart = new Highcharts.Chart(options1);

		// chart2
		var options2 = showPnlChartAll("pnlAllChart_all_futures", "Total PnL for All Market", dateArr); 
		options2.series.push( { name: "Total", data: pnlTotalArrCum_total, type: "line", tooltip:{valueDecimals:2} } );
		var chart = new Highcharts.Chart(options2);
	}
	else {
		$('#trade_summary_pnlTrend_all_futures').hide();
		$('#trade_summary_stats_all_closed_futures').hide();
		$('#trade_summary_stats_all_open_futures').hide();
		$('#trade_summary_stats').hide();
		$('#trade_summary_pnlTrend').show();
		var options = showLineBarChart("pnlTotalChart", "Total PnL", dateArr); 
		options.series.push( { name: "Daily PnL", yAxis: 0, data: pnlTotalArr, type: "column", tooltip:{valueDecimals:2} } );
		options.series.push( { name: "Total PnL", yAxis: 1, data: pnlTotalArrCum, type: "line", tooltip:{valueDecimals:2} } );
	 	options.series.push( { name: "Net PnL", yAxis: 1, data: pnlNetArrCum, type: "line", tooltip:{valueDecimals:2} } ); 
		var chart = new Highcharts.Chart(options);
	}
});

$('#trade_summary_download_futures, #trade_detail_download').on('click', function() {
	var table = $(this).closest('div.panel').find('table');
	var csv = table.table2CSV({
           delivery: 'value'
       });
	var link = document.createElement("a");
	link.download = $(this).prop('id') + '.csv';
	link.href = 'data:text/csv;charset=UTF-8,' + encodeURIComponent(csv);
	link.click();
});	

function showPnlChartAll(id, title, categories) { 
	var options = {
        colors: colorArray,
        chart: {
        	renderTo: id
        },
        credits:{
			enabled:false  
		},
		exporting: { enabled: true },
        title: {
            text: title,
            style: {
                color: '#111111',
                font: 'sans-serif',
                fontSize: '13'
            }
        },
        xAxis: {
            categories: categories,
//             labels:{
// 				rotation:-45
// 			},
			tickInterval: Math.round(categories.length / 13)
        },
        yAxis: {
            title: {
                text: "PnL Cumulative" // Values
            }
        },
        legend: {
            align:'center',
            verticalAlign:'bottom',
            x:0,
            y:0
        },
        plotOptions: {   // non-dot line with hover-radius 
            series: {
                marker: {
                    enabled: false,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 3
                        }
                    }
                }
            }
        },
        tooltip: {
            valuePrefix: '$',
            crosshairs: true,  // range line
            shared: true  // two datasets share tooltip
        },
        series: []
    };
	return options;
}

function showLineBarChart(id, title, categories) { 
	var options = {
        colors: colorArray,
        chart: {
        	renderTo: id
        },
        credits:{
			enabled:false  
		},
		exporting: { enabled: true },
        title: {
            text: title,
            style: {
                color: '#111111',
                font: 'sans-serif',
                fontSize: '13'
            }
        },
        xAxis: {
            categories: categories,
//             labels:{
// 				rotation:-45
// 			},
			tickInterval: Math.round(categories.length / 13)
        },
        yAxis: [{
            title: {
                text: "PnL Daily" // Values
            }
        }, {
        	title: {
                text: "PnL Cumulative" // Values
            },
            opposite: true
        }],
        legend: {
            align:'center',
            verticalAlign:'bottom',
            x:0,
            y:0
        },
        plotOptions: {   // non-dot line with hover-radius 
            series: {
                marker: {
                    enabled: false,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 3
                        }
                    }
                }
            }
        },
        tooltip: {
            valuePrefix: '$',
            crosshairs: true,  // range line
            shared: true  // two datasets share tooltip
        },
        series: []
    };
	return options;
}

$(document).ready(function() {

	// control panel validator
	$('#trade_form').validate({
		rules: {
			'trade_startDate': {
				required: true
			},
			'trade_endDate': {
				required: true
			}
		}   
	});

	

	$('#trade-all-tags').click(function() {
		if($(this).is(':checked')) 
			$('#trade-tag-input').prop('disabled', true).trigger("chosen:updated");
		else
			$('#trade-tag-input').prop('disabled', false).trigger("chosen:updated");
	});

	initLoading($("#trade_detail_panelBody"));
});

</script>