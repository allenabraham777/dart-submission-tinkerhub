import 'dart:io';

List stacks = ['Flutter','Python','Go','Web','UI/UX'];
List <Participant>participants = [];
List <int>mentors = [];

bool findmentor (var i, var stack, var available) {
  if(participants[i].stack == stack && participants[i].available == available)
    return true;
  return false;
}

void display (var i)
{
  print(participants[i].id.toString() + "  " + participants[i].name + " " + stacks[participants[i].stack] + " " + participants[i].available);
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

  void setAvailableTime () {

  }        

  void getMentor () {
    if (this.status == 'learner') {
      int i = 0;
      for (i in mentors) {
        if(findmentor(i,this.stack,this.available))
          this.mentorId = i;
          break;
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

            print("Enter the time when you are available (HH:MM AM/PM) :-");
            participant.available = stdin.readLineSync();

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
            participant.available = stdin.readLineSync();

            participant.getMentor();

            participants.add(participant);
            participant = null;

            break;
     case 3:print("Printed as follows");
            print("ID   NAME   STACK   AVAILABLE TIME");
            mentors.forEach(display);
            break;
     case 4:print("Printed as follows");
            print("ID   NAME   STACK   AVAILABLE TIME");
            for(int j = 0; j < participants.length; j++)
              if (participants[j].mentorId != -1)
                display(j);
            break;
   }
 } while(option > 0 && option < 5);
 print("Exiting...");
}