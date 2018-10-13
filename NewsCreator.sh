working_dir=$(pwd)
tmp_dir="$working_dir/../tmp"
echo $working_dir

. $working_dir/newsLinks.txt

for category in "${!home_links[@]}"; 
do 
	#echo $category ${home_links[$category]}; 	
	category_url=${home_links[$category]}
	category_home_file=$category".hmtl"
	echo "Get " $category " home"
	curl --create-dirs --data "my_user=3633932&my_pass=xwea1pvj" --output "$tmp_dir/$category_home_file" --silent $category_url
	
	
	echo "Parse " $category "home file for article links"
	a_article_links=($(python3 $working_dir/ParseAndGetArticleLinks.py "$tmp_dir/$category_home_file" | tr -d '[],'))

	tmp_articles_dir="$tmp_dir/"$category"Articles/"
	echo "Create folder "$tmp_articles_dir
	if [ ! -d $tmp_articles_dir ]; then 
		mkdir $tmp_articles_dir
	fi
	cd $tmp_articles_dir
	
	echo "Download each article"
	for i in "${a_article_links[@]}"
	do 	
		eval i=$i # remove '' in links
	
		echo "Download $i"	
		curl --create-dirs --data "my_user=3633932&my_pass=xwea1pvj" -O --silent "{$i}"
	done 
	
	echo "Parse articles and create doc"
	output_dir="$working_dir/../output"
	python3 $working_dir/ParseArticlesAndCreateDoc.py $tmp_articles_dir $tmp_dir $category

done

