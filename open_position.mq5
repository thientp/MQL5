//+------------------------------------------------------------------+
//|                                                  get_symbols.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#define EXPERT_MAGIC 123456
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
int handle; 

void Send_order(string symbolName)
{
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- 请求的参数
   request.action   =TRADE_ACTION_DEAL;                     // 交易操作类型
   request.symbol   = symbolName;                              // 交易品种
   request.volume   =0.01;                                   // 0.1手交易量 
   request.type     =ORDER_TYPE_BUY;                        // 订单类型
   request.price    =SymbolInfoDouble(Symbol(),SYMBOL_ASK); // 持仓价格
   request.deviation=5;                                     // 允许价格偏差
   request.magic    =EXPERT_MAGIC;                          // 订单幻数
//--- 发送请求
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d,symbol:%s",GetLastError(),symbolName);     // 如果不能发送请求，输出错误代码
//--- 操作信息
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
}

void OnStart()
  {
//---
      int sum = SymbolsTotal(false);
      int index = 0;
      string symbolName = "";
      
      while(index < sum)
      {
         symbolName = SymbolName(index,false);
         
         Send_order(symbolName);

         index++;
      }
      PrintFormat("number  %d",PositionsTotal());  //返回当前持仓数
      
      
     // handle=FileOpen("_trades.csv",FILE_CSV|FILE_WRITE,",");
    //  FileWrite(handle,"交易品种","Currency","Margin Currency","Execution","小数位","点差","下单","测试单号","交易类型","手数","标准手大小","杠杆","保证金(1手)","手续费/佣金","开仓价","平仓价","盈利点数","盈利金额");
   }
//+------------------------------------------------------------------+
