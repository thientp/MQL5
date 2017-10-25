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
void Send_order(string symbolName)
{
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- 请求的参数
   request.action   =TRADE_ACTION_DEAL;                     // 交易操作类型
   request.symbol   = symbolName;                              // 交易品种
   request.volume   =0.1;                                   // 0.1手交易量 
   request.type     =ORDER_TYPE_BUY;                        // 订单类型
   request.price    =SymbolInfoDouble(Symbol(),SYMBOL_ASK); // 持仓价格
   request.deviation=5;                                     // 允许价格偏差
   request.magic    =EXPERT_MAGIC;                          // 订单幻数
//--- 发送请求
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // 如果不能发送请求，输出错误代码
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
      
   
  }
//+------------------------------------------------------------------+
