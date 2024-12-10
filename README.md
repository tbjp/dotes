# 🎙️🔊🧑‍🏫 Dotes: AI-generated language learning podcasts

Dotes is an innovative language learning podcast app that leverages AI to create personalized podcasts for users. By specifying their language level, learning style, and interests, users can choose from premade topics or create their own. The app uses GPT to generate scripts and Google Cloud Text-to-Speech (TTS) to produce audio, featuring an AI host who speaks interchangeably in the user's native and target languages. Each podcast includes a transcript and flashcards to enhance the learning experience, making language acquisition engaging and tailored to individual needs.

<p align="center">
  <img src="https://github.com/user-attachments/assets/a16efc45-71e4-4953-81a2-292ffb7df6d2" width="200" />
  <img src="https://github.com/user-attachments/assets/0d238658-853d-4ec4-a124-ca6d21359951" width="200" />
  <img src="https://github.com/user-attachments/assets/2c82ba69-334b-41bf-97ee-1b04568b1999" width="200" />
  <img src="https://github.com/user-attachments/assets/fb3117d1-2d6b-41f2-8cfb-1806b3ae398a" width="200" />
</p>

<br>

[Check it out!](https://www.dotes.me)
   

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
OPENAI_KEY=your_own_openai_key
GOOGLE_JSON_KEY=json-string-google-cloud-key
(needs a TTS project active in Google cloud)
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping
- [GPT](https://openai.com/api/) - Script generation
- [Google Cloud TTS](https://cloud.google.com/text-to-speech) - Voice generation

## Acknowledgements
This project was initially created as a final project at Le Wagon. Many thanks to the teachers and team members for their incredible work.

## Team Members
- [Toby Palethorpe](https://www.linkedin.com/in/toby-palethorpe-826aaa90/)
- [Jarod Mizgaliski](https://www.linkedin.com/in/jarod-mizgalski-429546229/)
- [Bart Mikorski](https://github.com/Sadcrispy)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
