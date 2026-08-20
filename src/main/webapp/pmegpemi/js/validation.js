function validation() {

let btn = document.getElementById("buttonBlock");
        btn.addEventListner("click", function(){
        	let amount= document.getElementById("amount").value;
        	if(amount <= "2500000"){
        		Swal.fire('please check amount is more than 2500000')
        	    return false;
             }
             else{
                 return true;
             }
             });

        
	