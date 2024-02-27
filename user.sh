#!/bin/bash 
 #useradd 
 #Add new user 
 function adduser()
 { 
	while
        read -p  "Enter user namE: " username
do
	# Check if the username already exists
    if id "$username" &>/dev/null; then
	    echo "$username  already exist please enter new user"
    else

              sudo useradd -m  $username
              echo "user add successfully"
	      read -p "enter password for $username user" password
	      sudo passwd $password
	      echo "Done"
	      break
    fi
done
}
   

	    
     function reset_password() {
    read -p "Enter the username to reset password: " username

    # Check if the username exists
    if id "$username" &>/dev/null; then
        # Prompt for password 
        read -p "Enter the new password for $username: " password

        # Set the new password
        echo "$username:$password" | chpasswd
        echo "Password for user '$username' reset successfully."
    else
        echo "Error: The username '$username' does not exist. Please enter a valid username."
    fi
}

#delete user
 function delete(){
 read -p "Delete existing user:" user
sudo userdel $user
echo " $user delete successfully"
}
# Function to list all user accounts on the system
function list_users {
    
    echo "User Accounts on the System:"
    awk -F: '{print $1} ' /etc/passwd

}


#backup concept
backup()
{
src_dir="/home/ubuntu/learngit/scripts"
tgt_dir="/home/ubuntu/backups"
backup_filename="backup_$(date +%Y-%m-%d-%H-%M-%S).tar.gz"
echo "Backup started"
echo  "backing up to $backup_filename"
 tar -czvf "${tgt_dir}/${backup_filename}" "$src_dir"
 echo "Backup completed"
}
~

# Main program
while true
do
    echo "===== User Management System ====="
    echo "1. Add User"
    echo "2.Delete USer"
    echo "3.Reset password"
    echo "4. User list"
    echo "5.Genrate  Backup"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) adduser ;;
	2) delete ;;
	3) Reset password ;;
	4) list_users ;;
	5) backup ;;
        6) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please enter 1 or 2." ;;
    esac
done
