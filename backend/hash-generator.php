<?php
// Include your database connection file
include('connect.php');

// List of emails
$emails = [
    'john_andrei_agustin@dlsl.edu.ph',
    'janna_mikhaela_alcantara@dlsl.edu.ph',
    'enjey_kashlee_alonzo@dlsl.edu.ph',
    'jhenelle_alonzo@dlsl.edu.ph',
    'amaya_balion@dlsl.edu.ph',
    'alfonso_rafael_barte@dlsl.edu.ph',
    'regina_angeli_cadelina@dlsl.edu.ph',
    'djan_matthew_catibog@dlsl.edu.ph',
    'renz_andrei_delrosario@dlsl.edu.ph',
    'marc_lawrence_delapena@dlsl.edu.ph',
    'princess_mihaela_delavega@dlsl.edu.ph',
    'lyrus_lei_doctolero@dlsl.edu.ph',
    'kyle_gabriel_dones@dlsl.edu.ph',
    'juan_benjo_estrella@dlsl.edu.ph',
    'lenard_lance_fedelicio@dlsl.edu.ph',
    'harry_garcia@dlsl.edu.ph',
    'ivan_joseph_jaurigue@dlsl.edu.ph',
    'mark_jerome_kinchasan@dlsl.edu.ph',
    'jeric_lique@dls.edu.ph',
    'sean_calvin_theo_lirio@dlsl.edu.ph',
    'katherine_anne_liwanag@dlsl.edu.ph',
    'chester_boriz_macalintal@dlsl.edu.ph',
    'john_rafhael_steven_macasaet@dlsl.edu.ph',
    'alexie_chyle_magbuhat@dlsl.edu.ph',
    'john_aaron_manalo@dlsl.edu.ph',
    'ian_karvey_manimtim@dlsl.edu.ph',
    'isiah_joseph_marquinez@dlsl.edu.ph',
    'sebastian_angelo_meer@dlsl.edu.ph',
    'wyeth_irish_mendez@dlsl.edu.ph',
    'jan_ernest_pacey_nario@dlsl.edu.ph',
    'keith_justin_nario@dlsl.edu.ph',
    'michael_josh_panuela@dlsl.edu.ph',
    'jane_allyson_paray@dlsl.edu.ph',
    'daniel_luis_sahagun@dlsl.edu.ph',
    'thomas_alexandre_siman@dlsl.edu.ph',
    'xyrelle_dominique_talens@dlsl.edu.ph',
    'jhon_paulo_tenorio@dlsl.edu.ph',
    'kyan_prince_torres@dlsl.edu.ph'
];

echo "<pre>";

foreach ($emails as $email) {
    // Extract the first name from the email
    $local_part = explode('@', $email)[0]; // Get part before @
    $parts = explode('_', $local_part);     // Split by underscore
    $first_name = strtolower($parts[0]);    // Take the first segment as password
    
    // Generate bcrypt hash
    $hashed_password = password_hash($first_name, PASSWORD_DEFAULT);

    // Update the password in the database
    $stmt = $conn->prepare("UPDATE users SET password = ? WHERE email = ?");
    $stmt->bind_param("ss", $hashed_password, $email);

    if ($stmt->execute()) {
        echo "✅ Updated password for: $email | First Name: $first_name\n";
    } else {
        echo "❌ Failed to update password for: $email\n";
    }

    $stmt->close();
}

echo "</pre>";
$conn->close();
?>