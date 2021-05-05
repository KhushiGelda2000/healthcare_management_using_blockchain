pragma solidity ^0.5.0;

contract healthcare {
    uint public blockCount = 0;

    struct patientBlock {
        string patient_id;
        //uint patient_birth_year;
        string patient_name;
        uint patient_age;
        uint patient_aadhar_number;
        string patient_symptoms;
       // string patient_diagonis_for;
        string patient_precription;
        uint uprn;
        string doctor_name; 
        uint designation;  //0 for doctor
    }
    

    mapping(uint=>patientBlock) public record;

    constructor() public {
        addPatientBlock("khu123",
                        //2000,
                        "khushi", 
                        21,
                        123456789123,
                        "fever",
                        //"viral fever",
                        "Crocin Cold & Flu Max",
                        123456,
                        "Dr.Ajay Patni",
                        0);
        addPatientBlock("ish231",
                        //2001,
                        "Ishan", 
                        21,
                        987654321012,
                        "eyes watering",
                        //"Conjunctivitis",
                        "Ophthalmic eye drops",
                        654321,
                        "Dr.Sharma",
                        1);
    }

    //event o test new block created.
    event newPatientBlockCreated (
     string _patient_id,
     //uint _patient_birth_year,
     string _patient_name,
     uint _patient_age,
     uint _patient_aadhar_number,
     string _patient_symptoms,
   //  string _patient_diagonis_for,
     string _patient_precription,
     uint _uprn,
     string _doctor_name,
     uint _designation);
    //end of event

    //function to add new patient block 
    function addPatientBlock 
    (string memory _patient_id,
     //uint _patient_birth_year,   
     string memory _patient_name,
     uint _patient_age,
     uint _patient_aadhar_number,
     string memory _patient_symptoms,
     //string memory _patient_diagonis_for,
     string memory _patient_precription,
     uint _uprn,
     string memory _doctor_name,
     uint _designation)
     public {
        //here designation is 0 for doctor, so that only if doctor call record will be 
        //added, this can be returned from checkbox or radio from client side
        if(_designation==0) {
        blockCount++;

        record[blockCount] = patientBlock(_patient_id,
                                         // _patient_birth_year,
                                         _patient_name,
                                         _patient_age,
                                         _patient_aadhar_number,
                                         _patient_symptoms,
                                       //  _patient_diagonis_for,
                                         _patient_precription,
                                         _uprn,
                                         _doctor_name,
                                         _designation);
        //for test event is created.
            emit newPatientBlockCreated(_patient_id,
                                       // _patient_birth_year,
                                        _patient_name,
                                         _patient_age,
                                         _patient_aadhar_number,
                                         _patient_symptoms,
                                       //  _patient_diagonis_for,
                                         _patient_precription,
                                         _uprn,
                                         _doctor_name,
                                         _designation);
                            }
    }

    //event to test getPatientDetailByDoctor function
    event getPatientDetailEvent(
     string _patient_id);

    //function to fetch patient detail
    //before calling this function check if designation == 0
    function getPatientDetail
    ( string memory _patient_id) 
    view public returns(
        string memory,
        uint,
        uint,
        string memory,
        //string memory,
        string memory,
        uint,
        string memory,
        uint){
        //check valid uprn , uprn must be six digit number
        for(uint i=1; i<=blockCount; i++)
            {
                if (keccak256(abi.encodePacked(record[i].patient_id)) == keccak256(abi.encodePacked(_patient_id))){
                    return(record[i].patient_name,
                            record[i].patient_age,
                            record[i].patient_aadhar_number,
                            record[i].patient_symptoms,
                           // record[i].patient_diagonis_for,
                            record[i].patient_precription,
                            record[i].uprn,
                            record[i].doctor_name,
                            record[i].designation);
                }
                //emit getPatientDetailByDoctorEventAgent(_patient_aadhar_number,
                  //                                 _uprn);
                }
            }
}
    
