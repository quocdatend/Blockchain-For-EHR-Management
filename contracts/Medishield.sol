pragma solidity ^0.5.1;

contract Medishield {
    
    struct patient {
        string name;
        uint number;
        address[] healthcareAccessList;
        string diagnosis; // uint[]
        string record;
        address[] healthcareRequestList;
        // string[] listMedicine;
        address[] doctorSigns;
        // request order medicine
        address[] waitHandleRequestOrderMedicine; // 1
        address[] wasDeletedRequestOrderMedicine;  // -1
        address[] successRequestOrderMedicine; // 3
        address[] waitPaymentRequestOrderMedicine; // 2
        address[] cancelPaymentRequestOrderMedicine;
        address[] queuePatientGetMedicineSuccess;
    }
    
    struct healthcare {
        string name;
        uint number;
        uint designation;
        address[] patientAccessList; // view
        address[] queuDoctorSign; // sign
        // address[] queuePatient; // patients
         mapping(string => address[]) queuePatient;
        address[] queuePatientGetMedicine; // hospital
        address[] doctorAccessList; // hospital
        address[] accessJob; // doctor
        address[] patientOrderMedicineList; //  hospital
        string medicines; // hospital
        string specialty; // doctor
        string workingDays;
    }

    uint creditPool;
    address[] public patientList;
    address[] public healthcareList;
    // new 
    address[] public hospitalList;
    //

    mapping (address => patient) patientInfo;
    mapping (address => healthcare) healthcareInfo;
    //new
    mapping (address => healthcare) hospitalInfo;
    //
    mapping (address => address) Empty;
    mapping (address => string) patientRecords;
    

    function add_agent(string memory _name, uint _number, uint _designation, string memory _hash) public returns(string memory){
        address addr = msg.sender;
        if(_designation == 0){
            patient memory p;
            p.name = _name;
            p.number = _number;
            p.record = _hash;
            patientInfo[msg.sender] = p;
            patientList.push(addr)-1;
            return _name;
        }
       else if (_designation == 1){
            healthcare memory d;
            d.name = _name;
            d.number = _number;
            d.designation = _designation;
            //d.medincines = _hash;
            healthcareInfo[msg.sender] = d;
            healthcareList.push(addr)-1;
            return _name;
       }
       else if (_designation == 2){
            healthcare memory d;
            d.name = _name;
            d.number = _number;
            d.designation = _designation;
            d.medicines = _hash;
            hospitalInfo[msg.sender] = d;
            hospitalList.push(addr)-1;
            return _name;
       }
       else{
           revert();
       }
    }

    function get_patient(address addr) view public returns (string memory , uint, string memory , address, string memory, address){
        // if(keccak256(patientInfo[addr].name) == keccak256(""))revert();
        return (patientInfo[addr].name, patientInfo[addr].number, patientInfo[addr].diagnosis, Empty[addr], patientInfo[addr].record, Empty[addr]);
    }

    function get_healthcare(address addr) view public returns (string memory , uint, uint256){
        return (healthcareInfo[addr].name, healthcareInfo[addr].number, healthcareInfo[addr].designation);
    }
    function get_hospital(address addr) view public returns (string memory , uint, uint256, string memory){
        return (hospitalInfo[addr].name, hospitalInfo[addr].number, hospitalInfo[addr].designation, hospitalInfo[addr].medicines);
    }
    function get_patient_healthcare_name(address paddr, address daddr) view public returns (string memory , string memory ){
        return (patientInfo[paddr].name,healthcareInfo[daddr].name);
    }

    function permit_access(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        healthcareInfo[addr].patientAccessList.push(msg.sender)-1;
        patientInfo[msg.sender].healthcareAccessList.push(addr)-1;
    }
    function doctor_permit_access(address addr) payable public {
        require(msg.value == 1 ether);
        creditPool += 2;
        patientInfo[addr].healthcareRequestList.push(msg.sender)-1;
    }
    // new
    // function create_an_appointment(address addr) payable public {
    //     require(msg.value == 2 ether);
    //     creditPool += 2;
    //     healthcareInfo[addr].queuePatient.push(msg.sender)-1;
    // }
    function create_an_appointment(address addr, string memory date) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        healthcareInfo[addr].queuePatient[date].push(msg.sender);
    }
    //da sua
    function access_request_patient(address addr, string memory date) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        healthcareInfo[msg.sender].queuDoctorSign.push(addr)-1;
        creditPool -= 2;
        remove_element_in_array(healthcareInfo[msg.sender].queuePatient[date], addr);
    }
    
    function doctor_apply(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        hospitalInfo[addr].doctorAccessList.push(msg.sender)-1;
        healthcareInfo[msg.sender].accessJob.push(addr)-1;
    }
    function sign_records(address addr, string memory _hash) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        patientInfo[addr].doctorSigns.push(msg.sender)-1;
        set_hash(addr, _hash);
        creditPool -= 2;
        remove_element_in_array(healthcareInfo[msg.sender].queuDoctorSign, addr);
    }
    function request_ordor_medicine(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        hospitalInfo[addr].patientOrderMedicineList.push(msg.sender)-1;
        patientInfo[msg.sender].waitHandleRequestOrderMedicine.push(addr)-1;
    }
    function add_store_medicine(string memory _hash) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        hospitalInfo[msg.sender].medicines = _hash;
    }
    function remove_order_request(address addr) payable public{
        require(msg.value == 2 ether);
        creditPool -=1;
        remove_element_in_array(patientInfo[addr].waitHandleRequestOrderMedicine, msg.sender);
        remove_element_in_array( hospitalInfo[msg.sender].patientOrderMedicineList, addr);
        patientInfo[addr].wasDeletedRequestOrderMedicine.push(msg.sender)-1;
    }
    function remove_status_order_request(address addr) payable public{
        require(msg.value == 2 ether);
        creditPool -=1;
        remove_element_in_array(patientInfo[msg.sender].wasDeletedRequestOrderMedicine, addr);
    }
    function choice_specialty(string memory _name) payable public {
        require(msg.value == 2 ether);
        creditPool += 1;
        healthcareInfo[msg.sender].specialty = _name;
    }
    function set_working_days(string memory _hash) payable public {
        //require(healthcareInfo[msg.sender].designation == 1, "Not a doctor account.");
        healthcareInfo[msg.sender].workingDays = _hash;
    }
    function check_exits_buy_medicine(address addr, address paddr) public view returns(bool) {
        for (uint i = 0; i < hospitalInfo[addr].patientOrderMedicineList.length; i++) {
            if(hospitalInfo[addr].patientOrderMedicineList[i] == paddr) {
                return true;
            }
        }
        return false;
    }
    //
    function permit_access_and_remove_doctor_permit_access(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        healthcareInfo[addr].patientAccessList.push(msg.sender)-1;
        patientInfo[msg.sender].healthcareAccessList.push(addr)-1;
        creditPool -= 2;
        remove_element_in_array(patientInfo[msg.sender].healthcareRequestList, addr);
    }
    function cancel_access(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool -= 2;
        remove_element_in_array(patientInfo[msg.sender].healthcareRequestList, addr);
    }
    function permit_access_and_submitfile(address addr, address paddr, string memory  _hash) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        healthcareInfo[addr].patientAccessList.push(msg.sender)-1;
        patientInfo[msg.sender].healthcareAccessList.push(addr)-1;
        submitfile(paddr,_hash);
    }
    // show request 
    //must be called by healthcare.
    function submitfile(address paddr, string memory  _hash) public {
        bool patientFound = false;
        for(uint i = 0;i<healthcareInfo[msg.sender].patientAccessList.length;i++){
            if(healthcareInfo[msg.sender].patientAccessList[i]==paddr){
                msg.sender.transfer(2 ether);
                creditPool -= 2;
                patientFound = true;
            }
        }
        if(patientFound==true){
            set_hash(paddr, _hash);
            remove_patient(paddr, msg.sender);
        }else {
            revert();
        }
    }
    function remove_element_in_array(address[] storage Array, address addr) internal returns(uint)
    {
        bool check = false;
        uint del_index = 0;
        for(uint i = 0; i<Array.length; i++){
            if(Array[i] == addr){
                check = true;
                del_index = i;
            }
        }
        if(!check) revert();
        else{
            if(Array.length == 1){
                delete Array[del_index];
            }
            else {
                Array[del_index] = Array[Array.length - 1];
                delete Array[Array.length - 1];

            }
            Array.length--;
        }
    }

    function remove_patient(address paddr, address daddr) public {
        remove_element_in_array(healthcareInfo[daddr].patientAccessList, paddr);
        remove_element_in_array(patientInfo[paddr].healthcareAccessList, daddr);
    }
    
    function get_accessed_healthcarelist_for_patient(address addr) public view returns (address[] memory )
    { 
        address[] storage healthcareaddr = patientInfo[addr].healthcareAccessList;
        return healthcareaddr;
    }
    function get_request_healthcarelist_for_patient(address addr) public view returns (address[] memory )
    {
        address[] storage healthcareaddr = patientInfo[addr].healthcareRequestList;
        return healthcareaddr;
    }
    function get_accessed_patientlist_for_healthcare(address addr) public view returns (address[] memory )
    {
        return healthcareInfo[addr].patientAccessList;
    }
    // new
    // function get_appointment_first(address addr) public view returns (address[] memory ){
    //     address[] storage healthcareaddr = healthcareInfo[addr].queuePatient;
    //     return healthcareaddr;
    // }
    function get_appointment_first(address addr, string memory date) public view returns (address[] memory) {
        // Retrieve the queue for the specified date
        address[] storage healthcareaddr = healthcareInfo[addr].queuePatient[date];
        return healthcareaddr;
    }
    function get_queue_doctor_sign_first(address addr) public view returns (address[] memory ){
        address[] storage healthcareaddr = healthcareInfo[addr].queuDoctorSign;
        return healthcareaddr;
    }
    function get_employeees_hospital(address addr) public view returns (address[] memory) {
        address[] storage doctoraddr = hospitalInfo[addr].doctorAccessList;
        return doctoraddr;
    }
    function get_job_doctor(address addr) public view returns (address[] memory) {
        address[] storage doctoraddr = healthcareInfo[addr].accessJob;
        return doctoraddr;
    }
    function resign_job_from_doctor(address addr) public {
        remove_element_in_array(hospitalInfo[addr].doctorAccessList, msg.sender);
        remove_element_in_array(healthcareInfo[msg.sender].accessJob, addr);
    }
    function quit_job_from_hospital(address addr) public {
        remove_element_in_array(hospitalInfo[msg.sender].doctorAccessList, addr);
        remove_element_in_array(healthcareInfo[addr].accessJob, msg.sender);
    }
    function get_doctor_in_medicine(address addr) public view  returns (address[] memory) {
        return patientInfo[addr].doctorSigns;
    }
    function get_patient_order_medicine(address addr) public view returns(address[] memory) {
        address[] storage patientAddr =  hospitalInfo[addr].patientOrderMedicineList;
        return patientAddr;
    }
    function get_wait_handle_request_order_medicine(address addr) public view returns(address[] memory) {
        address[] storage hospitalAddr =  patientInfo[addr].waitHandleRequestOrderMedicine;
        return hospitalAddr;
    }
    function get_wait_payment_request_order_medicine(address addr) public view returns(address[] memory) {
        address[] storage hospitalAddr =  patientInfo[addr].waitPaymentRequestOrderMedicine;
        return hospitalAddr;
    }
    function get_was_deleted_request_order_medicine(address addr) public view returns(address[] memory) {
        address[] storage hospitalAddr =  patientInfo[addr].wasDeletedRequestOrderMedicine;
        return hospitalAddr;
    }
    function get_success_request_order_medicine(address addr) public view returns(address[] memory) {
        address[] storage hospitalAddr =  patientInfo[addr].successRequestOrderMedicine;
        return hospitalAddr;
    }
    function get_specialty_healthcare(address addr) public view returns(string memory) {
        return healthcareInfo[addr].specialty;
    }
 
    function get_working_days(address addr) public view  returns (string memory) {
         return healthcareInfo[addr].workingDays;
    }
    //
    function revoke_access(address daddr) public payable{
        remove_patient(msg.sender,daddr);
        msg.sender.transfer(2 ether);
        creditPool -= 2;
    }
    
    function get_patient_list() public view returns(address[] memory ){
        return patientList;
    }

    function get_healthcare_list() public view returns(address[] memory ){
        return healthcareList;
    }

    function get_hash(address paddr) public view returns(string memory ){
        return patientInfo[paddr].record;
    }
 
    function set_hash(address paddr, string memory _hash) internal {
        patientInfo[paddr].record = _hash;
    }

    //new
    function get_hospital_list() public view returns (address[] memory) {
        return hospitalList;
    }
  

    function getAddressesByField(string memory _field, bool isSpecialty) public view returns (address[] memory) {
        address[] memory matchingAddresses = new address[](healthcareList.length);
        uint count = 0;

        for (uint i = 0; i < healthcareList.length; i++) {
            string memory compareField = isSpecialty 
                ? healthcareInfo[healthcareList[i]].specialty 
                : healthcareInfo[healthcareList[i]].workingDays;

            // Kiểm tra giá trị
            if (
                (isSpecialty && keccak256(abi.encodePacked(compareField)) == keccak256(abi.encodePacked(_field))) || 
                (!isSpecialty && contains(compareField, _field))
            ) {
                matchingAddresses[count] = healthcareList[i];
                count++;
            }
        }

        
        address[] memory result = new address[](count);
        for (uint j = 0; j < count; j++) {
            result[j] = matchingAddresses[j];
        }

        return result;
    }
    function contains(string memory _base, string memory _value) internal pure returns (bool) {
        bytes memory baseBytes = bytes(_base);
        bytes memory valueBytes = bytes(_value);

        // Trả về false nếu chuỗi _value rỗng hoặc dài hơn chuỗi _base
        if (valueBytes.length == 0 || valueBytes.length > baseBytes.length) {
            return false;
        }

        for (uint i = 0; i <= baseBytes.length - valueBytes.length; i++) {
            bool matchFound = true;
            for (uint j = 0; j < valueBytes.length; j++) {
                if (baseBytes[i + j] != valueBytes[j]) {
                    matchFound = false;
                    break;
                }
            }
            if (matchFound) {
                return true;
            }
        }

        return false;
    }

    function send_request_payment(address addr, string memory _hash) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        hospitalInfo[msg.sender].medicines = _hash;
        patientInfo[addr].waitPaymentRequestOrderMedicine.push(msg.sender)-1;
        creditPool -= 1;
        remove_element_in_array(patientInfo[addr].waitHandleRequestOrderMedicine, msg.sender);
    }
    function payment_medicine_success(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool +=2;
        patientInfo[msg.sender].successRequestOrderMedicine.push(addr)-1;
        creditPool -= 1;
        remove_element_in_array(patientInfo[msg.sender].waitPaymentRequestOrderMedicine, addr);
    }
    function cancel_payment_medicine(address addr) payable public {
        require(msg.value == 2 ether);
        creditPool += 2;
        patientInfo[msg.sender].cancelPaymentRequestOrderMedicine.push(addr)-1;
        creditPool -=1;
        remove_element_in_array(patientInfo[msg.sender].waitPaymentRequestOrderMedicine, addr);
    }
    function get_cancel_payment_request_order_medicine(address addr) public view returns(address[] memory) {
            address[] storage hospitalAddr =  patientInfo[addr].cancelPaymentRequestOrderMedicine;
            return hospitalAddr;
        }

}