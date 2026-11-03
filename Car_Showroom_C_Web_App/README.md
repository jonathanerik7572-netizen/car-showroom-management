# Car Showroom Management System — C Web Application (Render-ready)

This is the Render/Docker version of the C project. The HTTP server, routing, application logic, CRUD operations, and CSV file handling are written in C. The C program generates the HTML pages; the browser renders them.

## Included features
- Dashboard: vehicle, availability, customer, and sales totals
- Vehicles: add, view, edit, and delete
- Customers: add, view, and delete
- Sales: record a sale against an available vehicle and registered customer
- A vehicle is marked Sold after its sale is recorded
- Local CSV persistence in `data/cars.csv`, `data/customers.csv`, and `data/sales.csv`
- Responsive HTML/CSS interface

## Deploy on Render (recommended steps)

### A. Upload the project to GitHub
1. Extract `Car_Showroom_C_Web_App.zip` on your computer.
2. Sign in to GitHub and create a new repository, for example `car-showroom-management`.
3. Open the extracted `Car_Showroom_C_Web_App` folder on your computer.
4. Upload the *contents* of that folder to the repository root. In particular, `server.c` and `Dockerfile` must be at the top level of the repository, not inside another nested project folder.
5. Commit the upload to the `main` branch.

### B. Create the Render Web Service
1. Sign in at https://render.com/.
2. From the Render Dashboard choose **New +** → **Web Service**.
3. Connect GitHub if asked, authorize Render, and select the `car-showroom-management` repository.
4. In the service configuration, set:
   - **Name:** `car-showroom-management` (or another available name)
   - **Branch:** `main`
   - **Language / Runtime:** `Docker`
   - **Region:** choose a region near your users, if available
   - **Instance Type:** `Free` for a classroom demonstration
   - **Dockerfile Path:** `./Dockerfile` (if Render asks)
   - **Docker Build Context Directory:** `.` (if Render asks)
5. Leave the Docker build and start commands blank; Render uses the included Dockerfile.
6. Click **Create Web Service**.
7. Open the **Logs** / **Events** view and wait for the build and deploy to finish. The service should become **Live**.
8. Open the `https://<your-service-name>.onrender.com` URL shown in the Render dashboard.

The C server reads Render's `PORT` environment variable (Render's default is 10000) and listens on `0.0.0.0`, as required for public web services.

## Test locally on Windows (MSYS2 UCRT64)
From the extracted project folder:

```bash
gcc server.c -o showroom.exe -lws2_32 -std=c11
./showroom.exe
```

Open `http://localhost:8080` in a browser. Stop the server with Ctrl+C.

## Data persistence — important
Render Free web services have an ephemeral filesystem. This means records saved in the CSV files can be lost when the service spins down, restarts, or redeploys. Free web services do not support persistent disks.

For durable CSV storage on Render, use a paid web service and attach a persistent disk with mount path `/app/data` (the app's CSV files are in that directory). Alternatively, redesign storage to use a managed database. Do not treat the free deployment as permanent record storage.

## Limitations
- This is an educational demonstration, not a production-ready showroom system.
- There is no login/authentication, role management, CSRF protection, or multi-user concurrency control.
- The simple pipe-delimited storage format means users should not enter the `|` character in form fields.
- Deleting a customer or vehicle does not remove historical sales records referring to it.
- Do not store real customer personal or financial information in this demo.

## Troubleshooting
- **Build fails:** confirm `server.c`, `Dockerfile`, `.dockerignore`, and `data/` are at the repository root.
- **Render cannot detect a port:** confirm the latest GitHub commit contains the `PORT` environment-variable handling in `server.c`; this ZIP already includes it.
- **404 / service unavailable:** check the Render Logs and wait until status is Live.
- **Changes do not appear:** confirm the latest commit was pushed and a new deploy completed.
