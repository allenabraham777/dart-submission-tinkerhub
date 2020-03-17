import 'dart:io';

List stacks = ['Flutter','Python','Go','Web','UI/UX'];
List <Participant>participants = [];
List <int>mentors = [];

void display (var i)
{
  if(participants[i].mentorId == -1)
    print(participants[i].id.toString() + "  " + participants[i].name + " " + stacks[participants[i].stack] + " " + participants[i].available);
  else
    print(participants[i].id.toString() + "  " + participants[i].name + " " + stacks[participants[i].stack] + " " + participants[participants[i].mentorId].name);
  // print(participants[i].id.toString() + ": " + participants[i].name + " " + participants[i].status+ " " + stacks[participants[i].stack] + " " + participants[i].available + " " + participants[participants[i].mentorId].name);
}

int pid = 0;
class Participant {
  int id;
  String name;
  int stack;
  String status;
  String available;
  int mentorId;

  Participant (var status) {
    this.id = pid++;
    this.name = "Participant $pid";
    this.stack = null;
    this.setMentorOrLearner(status);
    this.available = null;
    this.mentorId = null;
  }

  void addStacks (var i) {
    this.stack = stacks[i];
  }

  void setMentorOrLearner (var status) {
    this.status = status;
  }

  void setAvailableTime (var available) {
    this.available = available;
  }        

  void getMentor () {
    if (this.status == 'learner') {
      int i = 0;
      for (i in mentors) {
        if(participants[i].stack == this.stack)
        {
          this.mentorId = i;
          break;
        }
      }
    }
    else
      this.mentorId = -1;
  }
}

main () {
 int option;
 dynamic participant;
 do {
   print('Choose an option : \n1. Add Learner\n2. Add Mentor\n3. List Mentors\n4. List Learners\n5. Exit\n\n>>>');
   option = int.parse(stdin.readLineSync());
   switch (option) {
     case 1:participant = Participant("learner");

            print("Enter the Name :-");
            participant.name = stdin.readLineSync();

            print("Choose Your Stack:\n\n1.Flutter \n2.Python \n3.Go \n4.Web \n5.UI/UX\n\n>>");
            participant.stack = int.parse(stdin.readLineSync()) - 1;

            participant.getMentor();

            participants.add(participant);
            participant = null;

            break;
     case 2:participant = Participant("mentor");
            
            mentors.add(participant.id);

            print("Enter the Name :-");
            participant.name = stdin.readLineSync();

            print("Choose Your Stack:\n\n1.Flutter \n2.Python \n3.Go \n4.Web \n5.UI/UX\n\n>>");
            participant.stack = int.parse(stdin.readLineSync()) - 1;

            print("Enter the time when you are available (HH:MM AM/PM) :-");
            participant.setAvailableTime(stdin.readLineSync());

            participant.getMentor();

            participants.add(participant);
            participant = null;

            break;
     case 3:print("Printed as follows");
            print("ID   NAME   STACK   AVAILABLE TIME");
            mentors.forEach(display);
            break;
     case 4:print("Printed as follows");
            print("ID   NAME   STACK   Mentor");
            for(int j = 0; j < participants.length; j++)
              if (participants[j].mentorId != -1)
                display(j);
            break;
   }
 } while(option > 0 && option < 5);
 print("Exiting...");
}