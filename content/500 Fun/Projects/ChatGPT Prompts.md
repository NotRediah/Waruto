---
dg-publish: true
tags:
  - notion
---



> _**Automation for anki flashcard making back in grade 12 or 11 I think?**_

```visual-basic
Review Text: "Source text"

Task: Your task is to make conceptual and comprehensive flashcards using Anki cloze deletion mark-up. Ensure that each statement is clearly written, easily understandable, and adheres to the specified formatting and reference criteria. 

Formatting Criteria: 
- Construct a table with three columns: "Statements", "Notes", and "Number".
- Each row of the "Statements" column should contain a question and an answer in Anki cloze deletion mark-up, focusing on the question making the person think analytically
- Each row of the "Notes" column should provide additional explanations for the corresponding "Statement". There should be no cloze deletions in this column.
- The "Number" column should serve to number each row, facilitating feedback.

Reference Criteria for each "Statement":
- Restrict each statement to 1 cloze deletions. The cloze deletion hides the answer
- Be as comprehensive as need be but the statement column should not exceed 100 words. Extra information goes in the "Notes" column.
- Keep the text within the cloze deletions be as related to the provided text as possible but do make it compreshensive 
- Each statement must contain a question portion and an answer portion. Cloze deletion should only be used for the question portion
- Keep the question and the answer in the "Statements" column. Keep any additional explanatory information in the "Notes" column.

Example: 
| Statements | Notes | Number | 
| --- | --- | --- |
| Why is ammonia considered highly toxic in the context of nitrogenous waste excretion?
{{c1::Answer: Ammonia tends to raise the pH of body fluids and interferes with membrane transport functions, contributing to its high toxicity.}} | Ammonia neeeds 500ml of water per 1 gram of substance to be safely excreted | 1 |
| Explain the principles behind selecting a suitable kidney for transplantation, emphasizing the importance of ABO blood group compatibility and HLA matching.
{{c1::
Answer: Principles of Kidney Selection for Transplantation
Selecting a suitable kidney for transplantation involves key principles like ABO blood group compatibility and HLA matching. ABO blood group compatibility ensures that the donor and recipient have compatible blood types, reducing the risk of immediate rejection. Human leukocyte antigen (HLA) matching is crucial for graft success, as it minimizes the likelihood of immune reactions against the transplanted kidney. Both principles contribute to a successful transplantation by enhancing compatibility and reducing the risk of rejection.
}} | To increase the likelyhood of the success of the transplant immunosuppresents like cyclosporins are used  | 2 |
```

```jsx
You are an expert educator and instructional designer. Create a list of [number] open-ended, critical thinking questions from the text I'll provide :
General Instructions:
1. Provide with the level of Bloom's Taxonomy to which every question is aigned
2. Answer the questions in the following format:
   Q: _____________

    A:______________ 
3. Answer the questions with as much detail as needed to grasp the concept entirely

```

```jsx
Task: 
- Transform this dense source text into clear, concise bullet points that will be used to create educational flashcards later. Pay particular attention to the key facts and important details in the text. Focus on imaging features of diseases, unique imaging findings, and methods of differentiating similar disease entities.  Exclude historical and technical information.  This information is trivial and doesn’t contribute to the purpose of the educational materials, which is to help the user become a competent radiologist and diagnostician.
- Each bullet point must be able to stand alone. Include the subject of the bulleted statement somewhere in the text.
- Place all the bullet points in a plain text code block.

Source Text: "  "
```

```jsx
Format the text as follows:
Certainly! Here is the information formatted in a table:

| Questions | Answers |
| --- | --- |
| 1. Give a brief historical background of Pakistani culture? | The modern nation of Pakistan has inherited a very rich cultural and traditional background going back to the Indus Valley Civilization, 2800 BC-1800 BC. The region that is now Pakistan has in the past been invaded and occupied by many different people, including Elamo-Dravidians, Aryans, Greeks, White Huns, Persians, Arabs, Turks, Afghans, Mongols and various Eurasian groups. There are differences in culture among the different ethnic groups in matters such as dress, food, religion, especially where pre-Islamic customs differ from Islamic practices, pre-Islamic practices are being eroded as time goes by. |
| 2. What do you know about Kot Diji? | Kot Diji is situated between Ranipur and Khairpur on the highway from Hyderabad, at the east bank of the Indus close to Rohri. The discovery of Kot Diji provides evidence that there is civilization before Harappa and Mohenjo-Daro. The Kot Diji culture is marked by well-furnished, well-made pottery and houses built of mud-bricks on solid stone foundations. The Harappans borrowed some of the basic cultural elements from Kot Dijians. |
| 3. What is the significance of Harappa in the cultural heritage of Pakistan? | Located 10 km south-west of Lahore, Harappa is reached via Sahiwal, formerly known as Montgomery. Situated beside an earlier course of the Ravi River, Harappa was discovered in 1920-21, but through the ages, the site was quarried for bricks and most of the buildings excavated so far are in poor condition. The cemeteries discovered at Harappa confirm the Indus Valley people buried their dead, many of them wearing finger rings, necklaces of steatite beads, anklets of paste bead, earrings and shell bangles. |
| 4. What do you know about the ancient city of Mansura? | Mansura was the city founded by the Arabs after they occupied Sindh. The city had a strong fortification around, with four gateways. There was a magnificent mosque erected in the centre of the city. There are many stories about how the city named, most probably it was founded by Muhammad Bin Qassim’s son Omer and named “Mansura” to commemorate his round of victorious. Mansura is an Arabic word which means “success.” The city was later abandoned due to unknown reasons. The exact location of Mansura remained a matter of controversy among the researchers. Excavations carried out at Dalur between 1920-22 have revealed Arab coins, the remains of a mosque and certain other reliefs. |
| 5. Enlist the salient features of Muslim architecture? | The salient features of Muslim architecture are: Openness, which symbolizes Muslim broad-mindedness, tolerance and enlightenment. Balance and Coherence, which is the basic principle of the Islamic way of life Use of arch, minaret and dome, and also of the double dome, which is expressive of the Muslim aesthetic sense. Use of vertical lines instead of horizontal lines, which gives the building an air of loftiness, drive and upward motion. |
```