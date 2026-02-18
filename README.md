# Quis ut Deus? 🛡️

> *"Who is like God?"* — The battle cry of St. Michael the Archangel

A personal liturgical life dashboard that brings together daily readings, prayer tracking, and spiritual journaling into one unified experience. Built for Catholics who want to live intentionally with the rhythm of the Church.

---

## ✨ Features

### 📖 Liturgical Calendar
- Daily readings pulled from the Catholic Calendar API (First Reading, Psalm, Second Reading, Gospel)
- Saint of the day and feast day information
- Liturgical season and color theming — the app adapts visually to the Church's calendar
- Browse between days seamlessly with Hotwire Turbo Frames
- Readings cached in Postgres for fast, reliable access

### 🙏 Prayer Tracking
- Create and manage personal prayer habits (Rosary, Morning Prayer, Mass, Divine Office, Examen, Confession, and more)
- Daily or weekly frequency settings
- One-tap completion with instant UI updates via Turbo Streams
- Streak tracking — see how many consecutive days you've kept each habit
- Activate or deactivate habits as your spiritual routine evolves

### ✍️ Spiritual Journal
- Daily reflections tied to that day's liturgical readings
- Mood tagging (peaceful, grateful, joyful, reflective, struggling)
- Inline editing powered by Stimulus controllers
- Build a personal archive of your spiritual journey

### 📊 Dashboard & Progress
- Unified daily view: readings, prayers, and journal at a glance
- Personalized greeting based on time of day
- Prayer consistency charts over weeks and months
- GitHub-style habit grid for visual progress tracking
- Streak counters per habit

### 🔔 Reminders
- Optional email reminders for prayer times
- Background job processing with Sidekiq

---

## 🛠️ Tech Stack

| Layer          | Technology                          |
|----------------|-------------------------------------|
| Backend        | Ruby on Rails 7.2                   |
| Database       | PostgreSQL 16                       |
| Caching/Jobs   | Redis 7 + Sidekiq                   |
| Frontend       | Hotwire (Turbo + Stimulus)          |
| Styling        | Tailwind CSS                        |
| JavaScript     | esbuild                             |
| Containerization | Docker + Docker Compose           |
| Deployment     | DigitalOcean                        |
| Auth           | Devise                              |
| Charts         | Chartkick + Groupdate               |
| HTTP Client    | HTTParty                            |

---


  
   docker compose run --rm web bin/rails db:create
   docker compose run --rm web bin/rails db:migrate
   docker compose run --rm web bin/rails db:seed
   ```

---

## 📁 Project Structure

```
quis-ut-deus/
├── app/
│   ├── controllers/       # Dashboard, Pages, Prayer, Journal controllers
│   ├── helpers/            # View helpers (time greeting, liturgical colors)
│   ├── javascript/         # Stimulus controllers
│   ├── models/             # User, DailyReading, PrayerHabit, PrayerLog, JournalEntry
│   └── views/              # ERB templates styled with Tailwind
├── config/
│   ├── routes.rb           # Application routing
│   └── database.yml        # Postgres configuration via DATABASE_URL
├── db/
│   ├── migrate/            # Database migrations
│   └── seeds.rb            # Development seed data
├── Dockerfile              # Development container
├── Dockerfile.production   # Multi-stage production build
└── docker-compose.yml      # Docker Compose orchestration
```

---

## 🗓️ Development Roadmap

- [x] **Phase 1** — Foundation: Docker, Rails, Postgres, Tailwind, Devise, deploy scaffold
- [ ] **Phase 2** — Liturgical Calendar: API integration, daily readings, color theming
- [ ] **Phase 3** — Prayer Tracking & Journal: habits, streaks, journal entries, Turbo Streams
- [ ] **Phase 4** — Dashboard & Polish: charts, notifications, dark mode, responsive design
- [ ] **Phase 5** — Testing & Deployment: system tests, caching, production deploy

---

## 🌐 External APIs

- [Catholic Liturgical Calendar API](https://github.com/Liturgical-Calendar/LiturgicalCalendarFrontend) — Liturgical data, feast days, and seasons

---

## 📜 License

This project is for personal use.

---

## 🙏 Acknowledgments

- Inspired by St. Michael the Archangel and the Catholic Liturgical Tradition
- Built with the Ruby on Rails community's incredible ecosystem

---

*Ad Maiorem Dei Gloriam* 🛡️