var quote_array = [];

quote_array[0] = "It is a far, far better thing that I do, than I have ever done; it is a far, far better rest I go to than I have ever known. - A Tale of Two Cities, Charles Dickens";
quote_array[1] = "All we have to decide is what to do with the time that is given us. - The Fellowship of the Ring, J.R.R. Tolkein";
quote_array[2] = "You have brains in your head. You have feet in your shoes. You can steer yourself any direction you choose. You're on your own. And you know what you know. And YOU are the one who'll decide where to go  - Oh, the Places You ll Go!, Dr Seuss";
quote_array[3] = "It matters not what someone is born, but what they grow to be. - Harry Potter and the Goblet of Fire, J.K. Rowling";
quote_array[4] = "Whenever you feel like criticizing anyone   just remember that all the people in this world haven't had the advantages that you've had. - The Great Gatsby, F. Scott Fitzgerald ";
quote_array[5] = "Real courage is when you know you're licked before you begin, but you begin anyway and see it through no matter what. - To Kill a Mockingbird, Harper Lee";
quote_array[6] = "We are such stuff as dreams are made on, and our little life is rounded with a sleep. - The Tempest, William Shakespeare";
quote_array[7] = "A bear, however hard he tries, grows tubby without exercise. - When We Were Very Young, A. A. Milne";
quote_array[8] = "Not all those who wander are lost. - The Lord of the Rings, J.R.R. Tolkein";
quote_array[9] = "The Answer to the ultimate question of Life, The Universe and Everything is 42! - The Hitchhiker s Guide to the Galaxy, Douglas Adams";
quote_array[10] = "You have to write the book that wants to be written. And if the book will be too difficult for grown-ups, then you write it for children. - Madeleine L Engle";
quote_array[11] = "If you don t have time to read, you don t have the time (or the tools) to write. Simple as that. - Stephen King";
quote_array[12] = "We write to taste life twice, in the moment and in retrospect. - Anaïs Nin";
quote_array[13] = "Substitute  damn  every time you re inclined to write  very;  your editor will delete it and the writing will be just as it should be. - Mark Twain";
quote_array[14] = "If there s a book that you want to read, but it hasn t been written yet, then you must write it. - Toni Morrison";
quote_array[15] = "One day I will find the right words, and they will be simple. - The Dharma Bums, Jack Kerouac";
quote_array[16] = "Either write something worth reading or do something worth writing. - Benjamin Franklin";
quote_array[17] = "You never have to change anything you got up in the middle of the night to write. - Saul Bellow";
quote_array[18] = "No tears in the writer, no tears in the reader. No surprise in the writer, no surprise in the reader. - Robert Frost";
quote_array[19] = "Read, read, read. Read everything -- trash, classics, good and bad, and see how they do it. Just like a carpenter who works as an apprentice and studies the master. Read! You ll absorb it. Then write. If it s good, you ll find out. If it s not, throw it out of the window. - William Faulkner";
quote_array[20] = "You must stay drunk on writing so reality cannot destroy you. - Ray Bradbury";
quote_array[21] = "Words can be like X-rays if you use them properly, they ll go through anything. You read and you re pierced. - Brave New World, Aldous Huxley";
quote_array[22] = "How vain it is to sit down to write when you have not stood up to live. - Henry David Thoreau";
quote_array[23] = "I can shake off everything as I write; my sorrows disappear, my courage is reborn. - Anne Frank";
quote_array[24] = "A writer is someone for whom writing is more difficult than it is for other people. - Thomas Mann";
quote_array[25] = "Let me live, love, and say it well in good sentences. - Sylvia Plath";
quote_array[26] = "Don t bend; don t water it down; don t try to make it logical; don t edit your own soul according to the fashion. Rather, follow your most intense obsessions mercilessly. - Franz Kafka";
quote_array[27] = "I kept always two books in my pocket, one to read, one to write in. - Robert Louis Stevenson";
quote_array[28] = "You can make anything by writing. - C.S. Lewis";
quote_array[29] = "A word after a word after a word is power. - Margaret Atwood";
quote_array[30] = "Tears are words that need to be written. - Paulo Coelho";
quote_array[31] = "You should write because you love the shape of stories and sentences and the creation of different words on a page. Writing comes from reading, and reading is the finest teacher of how to write. - Annie Proulx";
quote_array[32] = "To survive, you must tell stories. - Umberto Eco";
quote_array[33] = "Always be a poet, even in prose. - Charles Baudelaire";
quote_array[34] = "If my doctor told me I had only six minutes to live, I wouldnt brood. Id type a little faster. - Isaac Asimov";
quote_array[35] = "The purpose of a writer is to keep civilization from destroying itself. - Albert Camus";
quote_array[36] = "I write to discover what I know. - Flannery O Connor";
quote_array[37] = "Ideas are like rabbits. You get a couple and learn how to handle them, and pretty soon you have a dozen. - John Steinbeck";

function generateQuote(){
	counter = Math.floor((Math.random()*37));
	document.getElementById("message").innerHTML = quote_array[counter];
	
}

var fact_array = [];
var counter = 0;

fact_array[0] = "The most expensive book ever purchased was the 'Codex Leicester', one of Leonardo Da Vinci's scientific journals. It was bought by Bill Gates for $30.8 million";
fact_array[1] = "'A la recherche du temps perdu' by Marcel Proust is the longest book in the world at 9,609,000 characters";
fact_array[2] = "Roald Dahl served in the Royal Air Force during World War II and also tested chocolates for Cadbury's while he was at school. ";
fact_array[3] = "In Victor Hugo's novel, 'Les Miserables', you can find a sentence that is 823 words long.";
fact_array[4] = "Charles Dickens believed that sleeping facing North, would improve his writing. He also carried a compass when travelling to make sure he was facing the right direction and he always touched things 3 times for luck.";
fact_array[5] = "Oxford English Dictionary notes the earliest use of the word 'wicked' to mean good/cool to be from Fitzgerald's novel 'This Side of Paradise'. ";
fact_array[6] = "The Governor of Hunan Province in China banned Lewis Carroll's Alice in Wonderland because he believed that animals should not be given the power to use the language of humans and to put animals and humans on the same level would be 'disastrous'.";
fact_array[7] = "According to Google, as of 2010, there were roughly 130 million books in print throughout the world. While counting the exact number is virtually impossible, the estimate was generated through an advanced Google algorithm that analysed more than 150 pieces of metadata relating to the world's books, and by discarding anything that was a duplicate or not by definition, a book.";
fact_array[8] = "The Dewey Decimal system is a library classification system created by Melvil Dewey in 1876. The system allows for books to be added to a library based on their subject matter rather than the order in which they were purchased.  The classification number that is assigned to the book makes it possible to find any book and return it to its rightful place on the shelf. Dewey is used in 200,000 libraries across 135 countries.";
fact_array[9] = "The top ten bestselling novels of all time have sold a combined total of just over 1.56 billion copies. Dan Brown's The Da Vinci Code comes in at number 10 with 80 million sold, and the classic novel Don Quixote by Miguel Cervantes is number one with 500 million copies sold.";
fact_array[10] = "Bibliosmia means the act of smelling books, and to some, it is as aromatic as perfume. And speaking of, there are more than a couple perfumes on the market that are meant to replicate the aroma of old books.";
fact_array[11] = "Beatrix Potter's most famous work Peter Rabbit was rejected a whopping six times by publishers. Potter ended up printing 250 copies herself and distributing them to family and friends. Sir Arthur Conan Doyle was among that group, and bought one for his children. When those sold out, she printed 200 more. In 1902, she was finally able to get it published with a traditional publisher, and since then Peter Rabbit has sold 45 million copies and been translated into 36 languages.";
fact_array[12] = "Beginning with the novel's popularization in the 18th century, the word 'a novel' started appearing on the cover under the title. While it might seem obvious to the modern reader that they are reading a novel, in the novel's early days, the genre wasn't clearly labeled on a shelf, so identifying the book as a novel was essential. 'A novel' still occasionally appears on modern works of fiction, partly out of tradition, and occasionally when the title and cover alone doesn't make the subject clear.";
fact_array[13] = "Stephen King was once taken for a vandal in an Australian bookshop where he was secretly signing copies of his books. A customer in the shop noticed a man walk in off the street and start signing books, and unaware that it was King, she notified the store staff. The misunderstanding was eventually cleared up, and 5 of the 6 books were given to community groups for fundraisers. The other book was purchased by the customer.";
fact_array[14] = "In her lifetime, Agatha Christie published 66 detective novels and 15 short story collections, but few people know she wrote six romance novels under the name Mary Westmacott. ";
fact_array[15] = "In 2013, J.K. Rowling secretly published an adult detective novel under the pseudonym Robert Galbraith. She created the alter-ego to escape the pressure of being the author of Harry Potter, and to allow the book to be evaluated on its own. Even Rowling's own publisher didn't know who Galbraith was when they first saw the novel.";
fact_array[16] = "President Theodore 'Teddy' Roosevelt was a voracious reader. He was known to read at least a book a day, and sometimes 2-3 if he had a free night.";
fact_array[17] = "The Dr. Seuss classic Green Eggs and Ham was written as a bet. Seuss bet his publisher $50 that he could write a book in 50 words or less. The book contains exactly 50 words.";
fact_array[18] = "August 9 is National Book Lovers Day and is a day to celebrate a love of reading. ";
fact_array[19] = "The slowest-selling book of all time is the Oxford University Press translation of the New Testament from Coptic to Latin. In 1716, five hundred copies were printed, and it took until 1907 for the last copy to sell.";
fact_array[20] = "The term 'Young Adult' was coined by the Young Adult Library Services Association in the 1960s to describe the 12-18 age range, and the literature of the time focused on mature and realistic themes for this group.";
fact_array[21] = "J.K. Rowling, author of the Harry Potter series of books, is the first author to gross a billion dollars for her books. ";
fact_array[22] = "When Victor Hugo's novel Les Miserables was published, Hugo was away on vacation. Wanting to know how the book had been received, he sent a telegram with a single question mark to his publishers. The publisher responded back with an exclamation point, signifying the book's success.";
fact_array[23] = "Robert Louis Stevenson, the author of Treasure Island, Kidnapped, and Jekyll and Hyde was born Robert Lewis Balfour Stevenson. At age 18, he dropped the Balfour from his name and changed Lewis to Louis (which he pronounced Lewis).";
fact_array[24] = "Since its inception, the Nobel Prize in Literature has been handed out 110 times to 114 laureates. The award is given to 'the person who shall have produced in the field of literature the most outstanding work in an ideal direction,' and has been won by writers from France more than any other country. In fact, the first recipient of the prize was French. Sully Prudhomme won in 1901 for a collection of poetry.";
fact_array[25] = "In Herman Melville's novel Moby Dick, Captain Ahab has a prosthetic leg made of whalebone, which he had custom made after having had his leg bitten off by the whale. The customary replacement for a missing limb at the time would have been wood, and analysts of the novel have suggested that the leg symbolizes Ahab's sense of masculinity.";
fact_array[26] = "The 1939 novel Gadsby by Ernest Vincent Wright does not use any words beginning with the letter E in the entire novel. The book was written as a lipogram, which is a kind of writing or word game in which the author deliberately excludes a common letter of the alphabet. ";
fact_array[27] = "Including television, theater, film and even radio, Charles Dickens is the most adapted author of all time. A Christmas Carol has been filmed over 50 times, and that figure doesn't include the number of other works that have borrowed its narrative. Oliver Twist, Great Expectations, and A Tale of Two Cities have also been frequently adapted to stage or screen.";
fact_array[28] = "Jules Verne, author of 20,000 Leagues Under the Sea and Around the World in Eighty Days and many other works, had a profound influence on science and invention. The designer of the submarine Simon Lake was inspired by Verne, and Alberto Santos-Dumont, a pioneer in aviation based his idea for the helicopter on ideas in Verne's work.";
fact_array[29] = "For over 70 years, The Little Prince has been a favourite book of adults and children alike, but the idea for the story came from an unusual source. Author Antoine de Saint-Exupery was a pilot, and the stories in the book were drawn from his experiences and hallucinations while waiting in the desert to be rescued.";
fact_array[30] = "The Columbian author Gabriel Garcia Marquez resolutely refused to allow his famous novel 100 Years of Solitude to be made into a movie. He wanted his readers to form their own images of his characters, and he said that 'By means of the letters I write they can imagine the characters to be as they wish, and not as the borrowed face of an actor.'";
fact_array[31] = "In 1935, the publisher Penguin Books introduced the first Penguin Paperback novels. Producing a book in paperback would offer readers high-quality literature but at a cheaper price than hard-bound books. Prior to their publication, the paperback book had a reputation for being trashy and poor quality. In 2003, sales of paperback books exceeded $3 billion.";
fact_array[32] = "Some of King's inspiration to write horror just might have come from his real life. When he was a young boy, he witnessed one of his friends getting hit bit a train. According to him, he has no memory of the event, he only knows that his mom told him he showed up back at their house that day, white as a ghost, and he refused to speak for the rest of the day.";



function prev_fact(){
	
	if (counter > 0){
		counter = counter - 1;
	} else{
		counter = fact_array.length - 1;
	}
		document.getElementById("fact").innerHTML = fact_array[counter];
}

function next_fact(){
	if (counter == fact_array.length-1){
		counter = 0;
	}else{
		counter = counter + 1;
	}
	
	document.getElementById("fact").innerHTML = fact_array[counter];
}

function validate(){
	if(document.contactForm.firstname.value == ""){
		document.getElementById("firstnameMessage").innerHTML = "(First name can't be left blank)";
		return false;
	}
	
	if(document.contactForm.lastname.value == ""){
	document.getElementById("lastnameMessage").innerHTML = "(Last name can't be left blank)";
	return false;
	}
	
	if(document.contactForm.email.value == ""){
		document.getElementById("emailMessage").innerHTML = "(Email can't be left blank)";
	}
	
	return true;
	
	
	
	
}

