
// if (typeof web3 !== 'undefined') {
//     web3 = new Web3(web3.currentProvider);
// } else {
//     // set the provider you want from Web3.providers
// web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));
// }

var web3;

var agentContractAddress = '0x155166978b23dD8E1831c274c63b69aeE11a44F1';

function connect(){
    web3 = new Web3(window.ethereum)
    window.ethereum.enable().catch(error => {
        // User denied account access
        console.log(error);
    })
    abi = JSON.parse('[{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_cancel_payment_request_order_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "cancel_payment_medicine", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "payment_medicine_success", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"},{"name": "_hash", "type": "string"}], "name": "send_request_payment", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "_hash", "type": "string"}], "name": "set_working_days", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "_hash", "type": "string"}], "name": "set_working_days", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_working_days","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_specialty_healthcare","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant": false, "inputs": [{"name": "_name", "type": "string"}], "name": "choice_specialty", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "remove_status_order_request", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "remove_order_request", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_success_request_order_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_was_deleted_request_order_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_wait_payment_request_order_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_wait_handle_request_order_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_patient_order_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant": false, "inputs": [{"name": "_hash", "type": "string"}], "name": "add_store_medicine", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "request_ordor_medicine", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_doctor_in_medicine","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"},{"name":"_hash","type":"string"}],"name":"sign_records","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"paddr","type":"address"}],"name":"quit_job_from_hospital","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"paddr","type":"address"}],"name":"resign_job_from_doctor","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_job_doctor","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_employeees_hospital","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_hospital","outputs":[{"name":"","type":"string"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"get_hospital_list","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"}],"name":"doctor_apply","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_queue_doctor_sign_first","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"},{"name":"date","type":"string"}],"name":"access_request_patient","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"},{"name":"date","type":"string"}],"name":"get_appointment_first","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"},{"name":"date","type":"string"}],"name":"create_an_appointment","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant": false,"inputs":[{"name":"addr","type": "address"},{"name": "paddr", "type": "address"},{"name":"_diagnosis","type":"uint256"},{"name":"_hash","type":"string"}], "name": "permit_access_and_submitfile", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "permit_access_and_remove_doctor_permit_access", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant": false, "inputs": [{"name": "addr", "type": "address"}], "name": "cancel_access", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_request_healthcarelist_for_patient","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_accessed_healthcarelist_for_patient","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"paddr","type":"address"},{"name":"daddr","type":"address"}],"name":"remove_patient","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"healthcareList","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"paddr","type":"address"},{"name":"daddr","type":"address"}],"name":"get_patient_healthcare_name","outputs":[{"name":"","type":"string"},{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"daddr","type":"address"}],"name":"revoke_access","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_patient","outputs":[{"name":"","type":"string"},{"name":"","type":"uint256"},{"name":"","type":"string"},{"name":"","type":"address"},{"name":"","type":"string"},{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_healthcare","outputs":[{"name":"","type":"string"},{"name":"","type":"uint256"},{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"insurerList","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"paddr","type":"address"}],"name":"get_hash","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_insurer","outputs":[{"name":"","type":"string"},{"name":"","type":"uint256"},{"name":"","type":"address[]"},{"name":"","type":"address[]"},{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"paddr","type":"address"}],"name":"accept_claim","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"patientList","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"}],"name":"permit_access","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"addr","type":"address"}],"name":"doctor_permit_access","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"get_healthcare_list","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"iaddr","type":"address"},{"name":"_diagnosis","type":"uint256[]"}],"name":"select_insurer","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"get_accessed_patientlist_for_healthcare","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"get_patient_list","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"get_insurer_list","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_name","type":"string"},{"name":"_number","type":"uint256"},{"name":"_designation","type":"uint256"},{"name":"_hash","type":"string"}],"name":"add_agent","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"paddr","type":"address"},{"name":"_hash","type":"string"}],"name":"submitfile","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_field","type":"string"},{"name":"isSpecialty","type":"bool"}],"name":"getAddressesByField","outputs":[{"name":"","type":"address[]"}],"payable":false,"stateMutability":"view","type":"function"}]');
    AgentContract = web3.eth.contract(abi);
    contractInstance = AgentContract.at(agentContractAddress);   
    web3.eth.defaultAccount = web3.currentProvider.selectedAddress;
    console.log("Web3 Connected:"+ web3.eth.defaultAccount );
    return web3.currentProvider.selectedAddress;
}

    
window.addEventListener('load', async () => {
    // New web3 provider
    connect();
    console.log("Externally Loaded!");
});