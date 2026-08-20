package pmegpchallan;

import java.util.Iterator;

public class geoDatamodel {
	Object transactionId;
	Object coldesc;
	Object colval;
	int rowid;
	
	public geoDatamodel(Object transactionId, Object coldesc, Object colval,int rowid) {
		
		this.transactionId = transactionId;
		this.coldesc = coldesc;
		this.colval = colval;
		this.rowid = rowid;
	}

	/**
	 * @return the appid
	 */
	public Object gettransactionId() {
		return transactionId;
	}

	/**
	 * @param appid the appid to set
	 */
	public void settransactionId(Object transactionId) {
		this.transactionId = transactionId;
	}

	/**
	 * @return the coldesc
	 */
	public Object getColdesc() {
		return coldesc;
	}

	/**
	 * @param coldesc the coldesc to set
	 */
	public void setColdesc(Object coldesc) {
		this.coldesc = coldesc;
	}

	/**
	 * @return the colval
	 */
	public Object getColval() {
		return colval;
	}

	/**
	 * @param colval the colval to set
	 */
	public void setColval(Object colval) {
		this.colval = colval;
	}

	/**
	 * @return the rowid
	 */
	public int getRowid() {
		return rowid;
	}

	/**
	 * @param rowid the rowid to set
	 */
	public void setRowid(int rowid) {
		this.rowid = rowid;
	}

	public Iterator<geoDatamodel> iterator() {
		// TODO Auto-generated method stub
		return null;
		}
	

}
