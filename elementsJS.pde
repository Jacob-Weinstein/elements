var moleculeMass = 0;
			var input = prompt("Enter the chemical formula");
			var elements = [];
			elements[0] = ["H",1.00794];
			elements[1] = ["He",4.00260];
			elements[2] = ["Li",6.941];
			elements[3] = ["Be",9.01218];
			elements[4] = ["B",10.81];
			elements[5] = ["C",12.011];
			elements[6] = ["N",14.0067];
			elements[7] = ["O",15.9994];
			elements[8] = ["F",18.9984];
			elements[9] = ["Ne",20.180];
			elements[10] = ["Na",22.98977];
			elements[11] = ["Mg",24.305];
			elements[12] = ["Al",26.98154];
			elements[13] = ["Si",28.0855];
			elements[14] = ["P",30.97376];
			elements[15] = ["S",32.065];
			elements[16] = ["Cl",35.453];
			elements[17] = ["Ar",39.948];
			elements[18] = ["K",39.0983];
			elements[19] = ["Ca",40.08];

			var polyAtomics = [
				["H3O","hydronium",1],
				["Hg2","mercury (I)",2],
				["NH4","ammonium",1],
				["C2H3O2","acetate",-1],
				["CH3COO","acetate",-1],
				["CN","cyanide",-1],
				["CO3","carbonate",-2],
				["HCO3","hydrogen carbonate",-1],
				["C2O4","oxalate",-2],
				["ClO","hypochlorite",-1],
				["ClO2","chlorite",-1],
				["ClO3","chlorate",-1],
				["ClO4","perchlorate",-1],
				["CrO4","chromate",-2],
				["Cr2O7","dichromate",-2],
				["MnO4","permanganate",-1],
				["NO2","nitrite",-1],
				["NO3","nitrate",-1],
				["O2","peroxide",-2],
				["OH","hydroxide",-1],
				["PO4","phosphate",-3],
				["SCN","thiocyanate",-1],
				["SO3","sulfite",-2],
				["SO4","sulfate",-2],
				["HSO4","hydrogen sulfate",-1],
				["S2O3","thiosulfate",-2]
			];

			function Bond(a1, a2, num){
				this.a1 = a1;
				this.a2 = a2;
				this.num = num;
			}

			function Atom(protons, electrons, oStates){
				this.protons = protons;
				this.electrons = electrons;
				this.oStates = oStates;
				this.bonds = [];
			}

			function findMass(id){
				for (var i = 0;i<elements.length;i++){
					if (elements[i][0] === id){
						return elements[i][1];
					}
				}
			}
			var eleString = "HHeLiBeBCBOFNeNaMgAlSiPSClArKCa";

			function removeDuplicates(values){
				for (var i = 0;i<values.length;i++){
					for (var j = 0;j<values.length;j++){
						if (i != j && values[i][0] === values[j][0]){
							values[i][1] += values[j][1];
							values[j][1] = 0;
						}
					}
				}
				var newNewArr = [];
				for (var i = 0;i<values.length;i++){
					if (values[i][1] > 0){
						newNewArr.push(values[i]);
					}
				}
				return newNewArr;
			}
			function addValuesToArray(values, array){
				for (var i = 0;i<values.length;i++){
					array.push(values[i]);
				}
			}
			function getComposition(rawr, mult){
				var ele = rawr.split(/(?=[A-Z])/);
				var vals = [];
				for (var i = 0;i<ele.length;i++){
					var strlen = ele[i].length;
					var temporary = [];
					if (isNaN(parseInt(ele[i].substring(strlen-1,strlen)))){
						temporary = [ele[i],mult];
						/*if (eleString.indexOf(ele[i]) == -1){
							alert("Error in processing. Please try again.");
							input = prompt("Enter the chemical formula");
							ele_raw = input.split("(");
						}*/
						console.log("default: slice: " + ele[i]);
					}else{
						var len = 1;
						while(!isNaN(parseInt(ele[i].substring(strlen-len-1,strlen)))){
							len++;
						}
						temporary = [ele[i].substring(0,strlen-len),parseInt(ele[i].substring(strlen-len))*mult];
						if (eleString.indexOf(ele[i].substring(0,strlen-len)) == -1){
							alert("Error in processing. Please try again.");
							window.location.reload(true);
						}
						console.log("slice: " +ele[i].substring(strlen-len-1));
						console.log("value: "+parseInt(ele[i].substring(strlen-len))*mult);
					}
					if (eleString.indexOf(ele[i].substring(0,strlen-len)) != -1){
						vals.push(temporary);
					}
					
				}
				console.log(vals);
				return vals;
			}
			var ele_raw = input.split("(");
			var master_arr = [];
			void setup(){
					for (var i = 0;i<ele_raw.length;i++){
				var multiplier = 1;
				var cur = ele_raw[i];
				var len = 0;
				if (input.indexOf(")") != -1 && cur.substring(cur.length-1,cur.length) != ")"){
					while (!isNaN(parseInt(cur.substring(cur.length-1-len,cur.length)))){
						len++;
					}
				}
				var closer = cur.indexOf(")");
				
				if (!isNaN(parseInt(cur.substring(closer+1)))){
					multiplier = parseInt(cur.substring(closer+1));
				}
				console.log("subscr substr: " + (cur.substring(cur.length-len,cur.length)));

				console.log("multiplier: " + multiplier);
				console.log("Len: " + len);
				
				console.log("cur: " + cur);
				if (closer != -1){
					cur = cur.substring(0,closer);
				}
				var n = getComposition(cur,multiplier);
				addValuesToArray(n,master_arr);
			}
			console.log(master_arr);

			//console.log("Duplicates removed\nmaster_arr.length = "+master_arr.length);



			var indis = [];
			for (var i = 0;i<master_arr.length;i++){
				moleculeMass += master_arr[i][1]*findMass(master_arr[i][0]);
				indis[i] = findMass(master_arr[i][0]);
			}
			var finstr = "<table id='t-actual'><tr><th>Element</th><th>Number of atoms</th><th>Percent composition by mass</th></tr>";
			for (var i = 0;i<master_arr.length;i++){
				console.log("writing element " + i);
				finstr += "<tr><td>"+master_arr[i][0]+"</td><td>"+master_arr[i][1]+"</td><td>"+((indis[i]*master_arr[i][1])/moleculeMass)+"</td></tr>";
				console.log(indis[i]);
			}
			console.log("molecule mass: " + moleculeMass);

			finstr += "</table>";
			document.getElementById("t-actual").innerHTML = finstr;
			document.getElementById("mass-p").innerHTML = "Gram-formula mass: " + moleculeMass;
			fill(255,0,0);
			rect(0,0,100,100);
			}
			void draw(){
				fill(255,0,0);
				rect(200,200,100,100);
			}