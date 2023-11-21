{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import numpy as np"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "metadata": {},
   "outputs": [],
   "source": [
    "links = pd.read_csv('links-spreadsheet.csv')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "109\n"
     ]
    }
   ],
   "source": [
    "print(len(links.index))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "metadata": {},
   "outputs": [],
   "source": [
    "df = links[['Section','Links','Main Category','Sub Category','Title']]\n",
    "df = df.dropna(subset=['Main Category'])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "metadata": {},
   "outputs": [],
   "source": [
    "df.head(3)\n",
    "category_list = list(set(df['Main Category'].to_list()))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "['Interactive and Web-based Applications', 'Programming Techniques and Tools', 'Parameter Analysis of Visualization Techniques', 'Data Visualization Techniques', 'Data Collection and Preprocessing', 'Outside of R', 'Statistical Analysis and Modelling']\n"
     ]
    }
   ],
   "source": [
    "print(category_list)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "metadata": {},
   "outputs": [],
   "source": [
    "df1 = df[df[\"Main Category\"] == \"Data Collection and Preprocessing\"]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "metadata": {},
   "outputs": [],
   "source": [
    "df1.head(10)\n",
    "subcategory_list1 = list(set(df1['Sub Category'].to_list()))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "['Miscellaneous']\n"
     ]
    }
   ],
   "source": [
    "print(subcategory_list1)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "metadata": {},
   "outputs": [],
   "source": [
    "category_list = sorted(category_list)\n",
    "category_list.append(category_list.pop(category_list.index('Outside of R')))\n",
    "\n",
    "for cat_nb in range(len(category_list)):\n",
    "    main_category = category_list[cat_nb]\n",
    "    df1 = df[df[\"Main Category\"] == main_category]\n",
    "\n",
    "    with open(f'project{cat_nb+1}.qmd', 'w') as f: #projecti.qmd\n",
    "        link_nb = 1\n",
    "        f.write(\"---\\n\")\n",
    "        f.write(f\"title: \\\"{main_category}\\\"\\n\")\n",
    "        f.write(\"---\\n\")\n",
    "\n",
    "        subcategory_list1 = list(set(df1['Sub Category'].to_list()))\n",
    "\n",
    "        # try:\n",
    "        subcategory_list1.append(subcategory_list1.pop(subcategory_list1.index('Miscellaneous')))\n",
    "        \n",
    "\n",
    "        for sub_nb, subcategory in enumerate(subcategory_list1):\n",
    "            df1_sub = df1[df1[\"Sub Category\"] == subcategory]\n",
    "            if len(subcategory_list1) > 1:\n",
    "                f.write(f\"# Subcategory {sub_nb + 1}: {subcategory}\\n\")\n",
    "            for video_nb in range(len(df1_sub['Title'].to_list())):\n",
    "                # print(len(df1_sub['Title'].to_list()))\n",
    "                title = df1_sub['Title'].to_list()\n",
    "                section = df1_sub['Section'].to_list()\n",
    "                links = df1_sub['Links'].to_list()\n",
    "                f.write(f\"[{link_nb}. {title[video_nb]} ({section[video_nb]})]({links[video_nb]})\\n\\n\")\n",
    "                link_nb += 1\n",
    "            f.write(\"\\n\")\n",
    "            "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "8"
      ]
     },
     "execution_count": 21,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "len(df1_sub['Title'].to_list())"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "web-scraping",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.5"
  },
  "orig_nbformat": 4
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
