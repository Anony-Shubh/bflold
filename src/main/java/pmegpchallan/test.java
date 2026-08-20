package pmegpchallan;

public class test {

	public static void main(String[] args) {
		//String var1="";
		String var1="021315651|011315651|021347606|031347606";
		pmegpchallanForView pcfv=new pmegpchallanForView();
		String result=pcfv.pmegpchallanID(var1);
		System.out.println(result);
		pcfv=null;
	}

}
