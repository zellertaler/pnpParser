working_dir=$(pwd)
tmp_dir="$working_dir/../tmp"
echo $working_dir

. $working_dir/newsLinks.txt

for category in "${!home_links[@]}"; 
do 
	echo $category ${home_links[$category]}; 
done

