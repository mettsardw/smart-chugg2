class Args{
  int subtotal;
  String txnID;
  Args(this.subtotal,this.txnID);
  Args.passSubtotal(this.subtotal);
  Args.passTxnID(this.txnID);
}