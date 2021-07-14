import { LightningElement,api,wire} from 'lwc';
import futureEvents from '@salesforce/apex/AttendeeEventsController.futureEvents';
import pastEvents from '@salesforce/apex/AttendeeEventsController.pastEvents';

const COLUMNS = [
    {label:'Event Name', fieldName:'eName', type:'text'},
    {label:'Event Location', fieldName:'eLocation', type:'text'},
    {label:'Start Date and Time', fieldName:'eStart', type:'date',
    typeAttributes:{day: 'numeric', month:'short', year:'numeric', hour:'2-digit', minute:'2-digit'}},
    {label:'End Date and Time', fieldName:'eEnd', type:'date',
    typeAttributes:{day: 'numeric', month:'short', year:'numeric', hour:'2-digit', minute:'2-digit'}}
    ]

export default class attendeeEvents extends LightningElement{
    @api recordId;
    futureEventsList
    pastEventsList
    columns = COLUMNS

    @wire (futureEvents, {attendeeId: '$recordId'})
    futureEventsRecord({error,data}){
        if(data){
            console.log(data);
            this.futureEventsList = data;
            let recordData = [];
            this.futureEventsList.forEach(dat =>{
                let eventData = {};
                let loc;
                if(dat.Event_List__r.Location_List__c){
                    loc = dat.Event_List__r.Location_List__r.Name;
                }else{
                    loc = "Location unavailable";
                }
                eventData.eName = dat.Event_List__r.Name__c;
                eventData.eLocation = loc;
                eventData.eStart = dat.Event_List__r.Event_Start_Date_Time__c;
                eventData.eEnd = dat.Event_List__r.Event_End_Date_Time__c;

                recordData.push(eventData);
                console.log(recordData);
            });
            this.futureEventsList = recordData;
        }else if(error){
            console.error(error);
        }
    }

    @wire (pastEvents, {attendeeId: '$recordId'})
    pastEventsRecord({error,data}){
        if(data){
            console.log(data);
            this.pastEventsList = data;
            let recordData = [];
            this.pastEventsList.forEach(dat =>{
                let eventData = {};
                let loc;
                if(dat.Event_List__r.Location_List__c){
                    loc = dat.Event_List__r.Location_List__r.Name;
                }else{
                    loc = "Location unavailable";
                }
                eventData.eName = dat.Event_List__r.Name__c;
                eventData.eLocation = loc;
                eventData.eStart = dat.Event_List__r.Event_Start_Date_Time__c;
                eventData.eEnd = dat.Event_List__r.Event_End_Date_Time__c;

                recordData.push(eventData);
                console.log(recordData);
            });
            this.pastEventsList = recordData;
        }else if(error){
            console.error(error);
        }
    }
}